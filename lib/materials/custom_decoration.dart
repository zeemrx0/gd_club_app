import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CustomDecoration {
  final BorderRadiusGeometry? borderRadius;
  final double opacity;

  BoxDecoration get glass {
    return BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(opacity),
          Colors.white.withOpacity(0.1),
        ],
      ),
      border: GradientBoxBorder(
        width: 2,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(opacity),
            Colors.white.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  CustomDecoration({
    this.borderRadius,
    this.opacity = 0.3,
  });
}
