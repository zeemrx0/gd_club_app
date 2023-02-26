import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatefulWidget {
  final List<Widget> actions;
  final Widget title;

  const CustomAppBar({
    this.title = const Text(''),
    this.actions = const [],
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
              if (Navigator.of(context).canPop())
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {});
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
                ),
              widget.title,
              Container(
                constraints: const BoxConstraints(
                  minWidth: 44,
                ),
                child: Row(
                  children: [
                    ...widget.actions.map(
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
