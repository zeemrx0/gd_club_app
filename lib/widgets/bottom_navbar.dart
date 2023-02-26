import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/screens/account/account_screen.dart';
import 'package:gd_club_app/screens/home_screen.dart';
import 'package:gd_club_app/screens/team/teams_screen.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context)!.settings.name);
    final currentRoute = ModalRoute.of(context)!.settings.name;

    return Container(
      width: 360,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            child: SizedBox(
              width: 60,
              child: Column(
                children: [
                  Icon(
                    Ionicons.home,
                    color: (currentRoute == '/' ||
                            currentRoute == HomeScreen.routeName)
                        ? Colors.purple[300]
                        : Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Trang chủ',
                    style: TextStyle(
                      color: currentRoute == '/'
                          ? Colors.purple[500]
                          : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: SizedBox(
              width: 60,
              child: Column(
                children: [
                  Icon(
                    Ionicons.calendar,
                    color: currentRoute == '/following'
                        ? Colors.purple[300]
                        : Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Theo dõi',
                    style: TextStyle(
                      color: currentRoute == '/following'
                          ? Colors.purple[500]
                          : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TeamsScreen.routeName);
            },
            child: SizedBox(
              width: 60,
              child: Column(
                children: [
                  Icon(
                    FluentSystemIcons.ic_fluent_organization_filled,
                    color: currentRoute == TeamsScreen.routeName
                        ? Colors.purple[300]
                        : Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Đội nhóm',
                    style: TextStyle(
                      color: currentRoute == TeamsScreen.routeName
                          ? Colors.purple[500]
                          : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AccountScreen.routeName);
            },
            child: SizedBox(
              width: 60,
              child: Column(
                children: [
                  Icon(
                    Ionicons.person,
                    color: currentRoute == AccountScreen.routeName
                        ? Colors.purple[300]
                        : Colors.grey[400],
                    size: 20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Tài khoản',
                    style: TextStyle(
                      color: currentRoute == AccountScreen.routeName
                          ? Colors.purple[500]
                          : Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
