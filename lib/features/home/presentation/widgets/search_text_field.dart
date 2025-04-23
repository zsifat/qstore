import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_event.dart';

class SearchTextField extends StatefulWidget {
  final Function(String)? onChanged;
  final String hintText;
  final FocusNode? focusNode;
  const SearchTextField({
    super.key,
    this.focusNode,
    this.onChanged,
    this.hintText = 'Search Anything...',
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearText() {
    _controller.clear();
    context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.search,
      controller: _controller,
      style: AppTextStyles.t16b400_000,
      onChanged: (value) {
        setState(() {});
        if(value.isEmpty){
          _clearText();
        }
      },
      onSubmitted: (value) {
        if(value.isNotEmpty){
          widget.onChanged?.call(value.trim());
        }else{
          context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SvgPicture.asset(AppConstants.searchIcon),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 66),
        suffixIcon: _controller.text.isNotEmpty
            ? GestureDetector(
            onTap: () {
              _controller.clear();
              context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
              FocusScope.of(context).unfocus();
              setState(() {});
            },
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