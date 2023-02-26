import 'package:flutter/material.dart';

class ShadowBoxDecoration {
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  BoxDecoration get value {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.06),
          blurRadius: 16,
        ),
      ],
    );
  }

  ShadowBoxDecoration({
    this.borderRadius,
    this.color,
  });
}
