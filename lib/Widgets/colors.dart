import 'package:flutter/material.dart';

Color kbackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.black // Dark theme background color
      : const Color(0xffeff1f7); // Light theme background color
}

Color kprimaryColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xff37474f) // Dark theme primary color (example)
      : const Color(0xff568A9f); // Light theme primary color
}

Color kBannerColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xff4caf50) // Dark theme banner color (example)
      : const Color(0xff579f8c); // Light theme banner color
}
