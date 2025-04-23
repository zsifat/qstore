import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qstore/features/home/presentation/widgets/search_text_field.dart';
import 'package:qstore/features/home/presentation/widgets/sort_filter_sheet.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/helper_methods.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_event.dart';

class SearchAndSortSection extends StatelessWidget {
  final ScrollController _scrollController;
  final FocusNode _focusNode;
  const SearchAndSortSection({super.key,required ScrollController scrollController,required FocusNode focusNode}) : _focusNode = focusNode, _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, bottom: 16,left: 16,right: 16),
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
    );
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