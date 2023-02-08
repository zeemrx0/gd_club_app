import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/materials/custom_decoration.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry? borderRadius;

  GlassCard({required this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: CustomDecoration(borderRadius: borderRadius).glass,
          child: child,
        ),
      ),
    );
  }
}
