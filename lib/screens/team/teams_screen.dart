import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/widgets/bottom_navbar.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
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
      appBar: const CustomAppBar(
        title: Text(
          'Đội nhóm',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    TeamList(currentAccount),
                  ],
                ),
              ),
            ],
          ),
          const BottomNavbar(),
        ],
      ),
    );
  }
}
