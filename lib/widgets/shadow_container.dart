import 'package:flutter/material.dart';
import 'package:gd_club_app/materials/shadow_box_decoration.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const ShadowContainer({
    required this.child,
    this.borderRadius,
    this.color,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: ShadowBoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ).value,
      child: child,
    );
  }
}
