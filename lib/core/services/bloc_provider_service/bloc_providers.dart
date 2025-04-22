import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/data/repository_implementations/product_repository_implementation.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_event.dart';

class BlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<ProductBloc>(
        create: (context) =>
            ProductBloc(ProductRepositoryImplementation()))
    ];
  }
}
