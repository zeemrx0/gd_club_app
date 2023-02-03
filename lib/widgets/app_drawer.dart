import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/materials/custom_decoration.dart';
import 'package:gd_club_app/screens/account/account_screen.dart';

import 'package:gd_club_app/screens/event/manage_events_screen.dart';
import 'package:gd_club_app/widgets/glass_card.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GlassCard(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                "Trang chủ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              title: const Text(
                "Quản lý sự kiện",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ManageEventsScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                "Tài khoản",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AccountScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red[300],
              ),
              title: Text(
                "Đăng xuất",
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 16,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
