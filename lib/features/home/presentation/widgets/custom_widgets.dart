import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qstore/core/constants/app_constants.dart';
import 'package:qstore/core/theme/app_colors.dart';
import 'package:qstore/core/theme/app_textstyles.dart';

class SearchTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    this.onChanged,
    this.hintText = 'Search Anything...',
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _debounce?.cancel();
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });

    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _hasText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: AppTextStyles.t16b400_000,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SvgPicture.asset(AppConstants.searchIcon),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 66),
        suffixIcon: _hasText
            ? GestureDetector(
          onTap: _clearText,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(AppConstants.crossIcon),
          ),
        )
            : null,
        suffixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 66),
        hintText: widget.hintText,
        hintStyle: AppTextStyles.t16b400_3AF,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutralGrey5DB, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutralGrey5DB, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    super.key,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(4))),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/9/9a/Wikipedia-T-shirt.jpg',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 10,
                        right: 16,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavourite=!isFavourite;
                            });
                          },
                          child: SvgPicture.asset(
                            isFavourite
                                ? AppConstants.favouriteDarkIcon
                                : AppConstants.favouriteOutlinedIcon,
                            width: 24,
                            height: 24,
                          ),
                        )),
                    Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                            decoration: BoxDecoration(
                              color: AppColors.redB30,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              'Out Of Stock',
                              style: AppTextStyles.t10b500_FFF,
                            )))
                  ],
                )),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Allen Solly Regular fit cotton shirt',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.t12b400_937,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                '\$35',
                style: AppTextStyles.t14b600_937,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '\$40.25',
                style: AppTextStyles.t10b500_3AF.copyWith(decoration: TextDecoration.lineThrough),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '15% OFF',
                style: AppTextStyles.t10b500_80C,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset(AppConstants.ratingIcon),
              SizedBox(
                width: 4,
              ),
              Text(
                '4.3',
                style: AppTextStyles.t12b500_937,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '(41)',
                style: AppTextStyles.t12b400_280,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FilterSheet extends StatelessWidget {
  const FilterSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 32),
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
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(AppConstants.crossIcon))
            ],
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Price: Low to High',style: AppTextStyles.t14b400_937,),
            onTap: () {
              // Handle Low to High action here
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Price: High to Low',style: AppTextStyles.t14b400_937,),
            onTap: () {
              // Handle High to Low action here
              Navigator.pop(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Rating',style: AppTextStyles.t14b400_937,),
            onTap: () {
              // Handle Rating action here
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}