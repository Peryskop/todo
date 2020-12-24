import 'package:flutter/material.dart';

class Background {
  static BoxDecoration gradientBackground(Color first, Color second) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [first, second],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
