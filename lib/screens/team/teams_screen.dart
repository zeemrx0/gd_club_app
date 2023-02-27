import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/team/edit_team_screen.dart';
import 'package:gd_club_app/widgets/bottom_navbar.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:gd_club_app/widgets/teams/team_list.dart';
import 'package:ionicons/ionicons.dart';
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
      appBar: CustomAppBar(
        title: const Text(
          'Đội nhóm',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(EditTeamScreen.routeName);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple[400],
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
                  Ionicons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
