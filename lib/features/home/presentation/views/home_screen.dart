import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/network_bloc/network_connectivity_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/network_bloc/network_connectivity_state.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_state.dart';
import '../../../../core/shared/custom_widget.dart';
import '../bloc/product_bloc/product_event.dart';
import '../widgets/product_grid_section.dart';
import '../widgets/search_sort_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
    _scrollController.addListener(() {
      _focusNode.unfocus();
      final productState = context.read<ProductBloc>().state;
      if (productState is! ProductLoaded || !productState.isSearch) {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent-200 &&
            !_scrollController.position.outOfRange) {
          if (productState is ProductLoaded && !productState.hasMore) {
            showEndOfProductPageSnackbar(context);
          } else {
            context.read<ProductBloc>().add(FetchProducts());
          }
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<NetworkConnectivityBloc,NetworkConnectivityState>(
          listener: (context, state) {
            if (state is NetworkDisconnected) {
              showNoInternetSnackbar(context);
            }
            if(state is NetworkConnected){
              context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
            }
          },
          child: Column(
            children: [
              SearchAndSortSection(scrollController: _scrollController, focusNode: _focusNode),
              ProductGridSection(scrollController: _scrollController),
            ],
          ),
        ));
  }

}
