import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gd_club_app/materials/shadow_box_decoration.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  const ShadowContainer({
    required this.child,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShadowBoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ).value,
      child: child,
    );
  }
}
