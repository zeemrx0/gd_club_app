import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CustomDecoration {
  final double borderRadius;
  final double opacity;

  BoxDecoration get glass {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
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

  BoxDecoration get glassDrawer {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ),
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
    this.borderRadius = 10,
    this.opacity = 0.3,
  });
}
