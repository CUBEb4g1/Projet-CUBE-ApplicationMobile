// Import lib modules
import 'package:flutter/material.dart';

class Screen {
  Size screenSize;
  Screen._internal();
  Screen(this.screenSize);
  // Width resizing
  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }
  // Height resizing
  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }
  // Proportionality ratio
  double getWidthPx(int pixels) {
    return (pixels / 3.61) / 100 * screenSize.width;
  }
}