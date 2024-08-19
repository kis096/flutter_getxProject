import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  double get hp => Get.height * (this / 100);
  double get wp => Get.width * (this / 100);
}

extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) {
    final alpha = this.alpha.toRadixString(16).padLeft(2, '0');
    final red = this.red.toRadixString(16).padLeft(2, '0');
    final green = this.green.toRadixString(16).padLeft(2, '0');
    final blue = this.blue.toRadixString(16).padLeft(2, '0');
    return '${leadingHashSign ? '#' : ''}$alpha$red$green$blue';
  }
}
