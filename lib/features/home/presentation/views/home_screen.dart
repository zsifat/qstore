import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qstore/core/constants/app_constants.dart';
import 'package:qstore/core/utils/helper_methods.dart';
import 'package:qstore/features/home/presentation/bloc/network_bloc/network_connectivity_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/network_bloc/network_connectivity_state.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_state.dart';
import 'package:qstore/features/home/presentation/widgets/custom_widgets.dart';

import '../bloc/product_bloc/product_event.dart';
import '../widgets/lottie_display.dart';
import '../widgets/product_container.dart';
import '../widgets/search_text_field.dart';
import '../widgets/shimmer.dart';

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
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(FetchProducts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<NetworkConnectivityBloc,NetworkConnectivityState>(
          listener: (context, state) {
            if (state is NetworkDisconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("You're offline")),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: HelperMethods.statusBarHeight, bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchTextField(
                          focusNode: _focusNode,
                          onChanged: (p0) {
                            context.read<ProductBloc>().add(FetchSearchedProducts(p0));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            _focusNode.unfocus();
                            _showFilterModal(context);
                          },
                          child: SvgPicture.asset(
                            AppConstants.filterIcon,
                            width: 48,
                          ))
                    ],
                  ),
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return ShimmerGridView();
                    } else if (state is ProductLoaded) {
                      if (state.productResponse.products.isNotEmpty) {
                        return Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: state.productResponse.products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) {
                              return ProductContainer(
                                productModel: state.productResponse.products[index],
                              );
                            },
                          ),
                        );
                      } else {
                        return Expanded(
                            child: LottieDisplay(
                                animationPath: AppConstants.noItemLottie,
                                message: 'No Items Found'));
                      }
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      builder: (context) => const FilterSheet(),
    ).then((value) {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    },);
  }
}
