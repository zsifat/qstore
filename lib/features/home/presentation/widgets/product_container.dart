import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qstore/core/constants/app_constants.dart';
import 'package:qstore/core/theme/app_colors.dart';
import 'package:qstore/core/theme/app_textstyles.dart';
import 'package:qstore/core/utils/helper_methods.dart';
import 'package:qstore/features/home/data/model/product_model.dart';

class ProductContainer extends StatefulWidget {
  final ProductModel productModel;

  const ProductContainer({super.key, required this.productModel});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  bool isFavourite = false;

  void _toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  void initState() {
    super.initState();
    isFavourite= widget.productModel.rating>= 4.5 ? true :false;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productModel;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(product),
          const SizedBox(height: 8),
          _buildProductTitle(product),
          const SizedBox(height: 8),
          _buildPriceRow(product),
          const SizedBox(height: 8),
          _buildRatingRow(product),
        ],
      ),
    );
  }

  // Build product image section
  Widget _buildImageSection(ProductModel product) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            CachedNetworkImage(
              imageUrl: product.thumbnail,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            _buildFavouriteIcon(),
            if (product.availabilityStatus == 'Out of Stock')
              _buildOutOfStockLabel(product),
          ],
        ),
      ),
    );
  }

  // Build the favourite icon button
  Widget _buildFavouriteIcon() {
    return Positioned(
      top: 10,
      right: 16,
      child: GestureDetector(
        onTap: _toggleFavourite,
        child: SvgPicture.asset(
          isFavourite ? AppConstants.favouriteDarkIcon : AppConstants.favouriteOutlinedIcon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  // Build out of stock label
  Widget _buildOutOfStockLabel(ProductModel product) {
    return Positioned(
      top: 4,
      left: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.redB30,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          product.availabilityStatus,
          style: AppTextStyles.t10b500_FFF,
        ),
      ),
    );
  }

  // Build product title with overflow handling
  Widget _buildProductTitle(ProductModel product) {
    return Text(
      product.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.t12b400_937,
    );
  }

  // Build product price and discount row
  Widget _buildPriceRow(ProductModel product) {
    return Row(
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: AppTextStyles.t14b600_937,
        ),
        const SizedBox(width: 4),
        Text(
          '\$${HelperMethods.calculateOriginalPrice(product.price, product.discountPercentage).toStringAsFixed(2)}',
          style: AppTextStyles.t10b500_3AF.copyWith(decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(width: 4),
        Text(
          '${product.discountPercentage.round()}% OFF',
          style: AppTextStyles.t10b500_80C,
        ),
      ],
    );
  }

  // Build product rating row
  Widget _buildRatingRow(ProductModel product) {
    return Row(
      children: [
        SvgPicture.asset(AppConstants.ratingIcon),
        const SizedBox(width: 6),
        Text(
          product.rating.toStringAsPrecision(2),
          style: AppTextStyles.t12b500_937,
        ),
        const SizedBox(width: 6),
        Text(
          '(${product.reviews.length})',
          style: AppTextStyles.t12b400_280,
        ),
      ],
    );
  }
}