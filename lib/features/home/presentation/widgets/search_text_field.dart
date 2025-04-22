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
    if(_controller.text.isNotEmpty){
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 800), () {
        if (widget.onChanged != null && _controller.text.isNotEmpty) {
          widget.onChanged!(_controller.text);
        }
      });

      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    }else{
      _clearText();
    }
  }

  void _clearText() {
    _controller.clear();
    context.read<ProductBloc>().add(FetchProducts(isRefresh: true));
    setState(() {
      _hasText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
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