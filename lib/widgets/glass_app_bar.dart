import 'package:flutter/material.dart';
import 'package:gd_club_app/widgets/glass_card.dart';

class GlassAppBar extends StatelessWidget {
  final List<Widget> actions;
  final Widget title;

  const GlassAppBar({
    this.title = const Text(''),
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
              if (!Navigator.of(context).canPop())
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: GlassCard(
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (Navigator.of(context).canPop())
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: GlassCard(
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.arrow_back_ios_new,
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
                    ...actions.map(
                      (action) => Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          action,
                        ],
                      ),
                    ),
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
