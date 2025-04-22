import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qstore/core/constants/app_constants.dart';
import 'package:qstore/core/theme/app_textstyles.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_event.dart';


class FilterSheet extends StatelessWidget {
  const FilterSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sort By', style: AppTextStyles.t16b600_937),
              GestureDetector(
                  onTap: () {
                    context.read<ProductBloc>().add(ClearSort());
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(AppConstants.crossIcon))
            ],
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Price: Low to High',
              style: AppTextStyles.t14b400_937,
            ),
            onTap: () {
              context.read<ProductBloc>().add(SortProducts(SortOption.priceLowToHigh));
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Price: High to Low',
              style: AppTextStyles.t14b400_937,
            ),
            onTap: () {
              context.read<ProductBloc>().add(SortProducts(SortOption.priceHighToLow));
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Rating',
              style: AppTextStyles.t14b400_937,
            ),
            onTap: () {
              context.read<ProductBloc>().add(SortProducts(SortOption.ratingHighToLow));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}