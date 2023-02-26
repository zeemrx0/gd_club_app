import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final Widget title;

  const CustomAppBar({
    this.title = const Text(''),
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return PreferredSize(
      preferredSize: const Size(
        double.infinity,
        76,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 16,
          top: MediaQuery.of(context).padding.top + 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: const BoxConstraints(
                minWidth: 44,
              ),
              child: canPop
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.06),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Ionicons.arrow_back,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  : null,
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.infinity,
        76,
      );
}
