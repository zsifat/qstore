import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qstore/core/constants/app_constants.dart';
import 'package:qstore/core/theme/app_textstyles.dart';
import 'package:qstore/core/utils/helper_methods.dart';
import 'package:qstore/features/home/presentation/widgets/custom_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: HelperMethods.statusBarHeight,bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SearchTextField(
                      onChanged: (p0) {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () => _showFilterModal(context),
                      child: SvgPicture.asset(
                        AppConstants.filterIcon,
                        width: 48,
                      ))
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return ProductContainer();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const OutlineInputBorder(borderRadius: BorderRadius.zero),
      builder: (context) => const FilterSheet(),
    );
  }
}
