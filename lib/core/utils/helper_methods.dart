import 'package:flutter/material.dart';

class HelperMethods{
  static double get statusBarHeight {
    return WidgetsBinding.instance.window.padding.top/2;
  }

  static double calculateOriginalPrice(double discountedPrice, double discountPercentage) {
    double originalPrice = discountedPrice / (1 - (discountPercentage / 100));
    return originalPrice;
  }

}
