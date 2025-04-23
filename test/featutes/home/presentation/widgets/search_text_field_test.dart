import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_state.dart';
import 'package:qstore/features/home/presentation/widgets/search_text_field.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_event.dart';

class MockProductBloc extends Mock implements ProductBloc {}
class FakeProductEvent extends Fake implements ProductEvent {}
class FakeProductState extends Fake implements ProductState {}

void main() {
  late MockProductBloc mockBloc;

  setUp(() {
    registerFallbackValue(FakeProductEvent());
    mockBloc = MockProductBloc();
    when(() => mockBloc.stream).thenAnswer((_) => Stream.value(FakeProductState()));
    when(() => mockBloc.add(FetchProducts(isRefresh: true))).thenAnswer((_) async {});
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockBloc,
        child: Scaffold(body: child),
      ),
    );
  }

  testWidgets('typing text updates the field and shows clear icon', (tester) async {
    await tester.pumpWidget(makeTestableWidget(SearchTextField()));
    await tester.enterText(find.byType(TextField), 'phone');

    await tester.pump();

    expect(find.text('phone'), findsOneWidget);


    final crossIcon = find.byType(SvgPicture).at(1);
    expect(crossIcon, findsOneWidget);

    await tester.tap(crossIcon);
    expect(find.text('phone'), findsNothing);
  });

  testWidgets('submitting empty input dispatches FetchProducts', (tester) async {
    when(() => mockBloc.state).thenReturn(ProductInitial());
    when(() => mockBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpWidget(makeTestableWidget(SearchTextField()));

    await tester.enterText(find.byType(TextField), '');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    verify(() => mockBloc.add(FetchProducts(isRefresh: true))).called(1);
  });


  testWidgets('submitting non-empty input calls onChanged', (tester) async {
    String? searchedQuery;

    await tester.pumpWidget(makeTestableWidget(
      SearchTextField(onChanged: (value) => searchedQuery = value),
    ));

    await tester.enterText(find.byType(TextField), 'laptop');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(searchedQuery, 'laptop');
  });
}
