import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:gd_club_app/widgets/bottom_navbar.dart';
import 'package:gd_club_app/widgets/teams/team_list.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatefulWidget {
  static const routeName = '/teams';

  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  Widget build(BuildContext context) {
    final Account currentAccount = Provider.of<Auth>(context).account!;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView(
            children: [
              TeamList(currentAccount),
            ],
          ),
          const Positioned(
            bottom: 12,
            child: BottomNavbar(),
          ),
        ],
      ),
    );
  }
}
