import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/materials/custom_decoration.dart';

class GlassAppBar extends StatelessWidget {
  final List<Widget> actions;
  final Widget title;

  const GlassAppBar({
    this.title = const Text(""),
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16, top: 16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  decoration: CustomDecoration(
                    borderRadius: 8,
                  ).glass,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title,
              Container(
                constraints: const BoxConstraints(
                  minWidth: 44,
                ),
                child: Row(
                  children: [
                    ...this.actions,
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
