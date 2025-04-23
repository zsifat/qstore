import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/presentation/widgets/product_container.dart';
import 'package:qstore/features/home/presentation/widgets/shimmer.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/shared/custom_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_state.dart';

class ProductGridSection extends StatelessWidget {
  const ProductGridSection({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return ShimmerGridView();
        } else if (state is ProductLoaded) {
          if (state.productResponse.products.isNotEmpty) {
            return Expanded(
              child: Column(
                children: [
                  if(state.isSearch)
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.neutralGreyAFB
                      ) ,
                      height: 34,
                      width: double.infinity,
                      child: Center(child: Text('${state.productResponse.products.length} Items',style: AppTextStyles.t12b500_937,)),
                    ),
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 32),
                      itemCount: state.productResponse.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return ProductContainer(
                          productModel: state.productResponse.products[index],
                        );
                      },
                    ),
                  ),
                ],
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
    );
  }
}