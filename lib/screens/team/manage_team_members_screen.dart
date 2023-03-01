import 'package:flutter/material.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/memberships.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:gd_club_app/widgets/teams/team_member_item.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ManageTeamMembersScreen extends StatefulWidget {
  static const routeName = '/manage-members';

  const ManageTeamMembersScreen({super.key});

  @override
  State<ManageTeamMembersScreen> createState() =>
      _ManageTeamMembersScreenState();
}

class _ManageTeamMembersScreenState extends State<ManageTeamMembersScreen> {
  @override
  Widget build(BuildContext context) {
    final teamId = ModalRoute.of(context)!.settings.arguments as String;

    final Team team = Provider.of<Teams>(context).findTeamById(teamId)!;

    final members =
        Provider.of<Memberships>(context).getMemberListOfATeam(teamId);

    final List<String> memberIds = members.keys.toList();
    final List<List<Role>> memberRoles = members.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: Column(
        children: [
          CustomAppBar(
            title: Text(
              team.name,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(EditEventScreen.routeName);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
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
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: members.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: TeamMemberItem(memberIds[index], memberRoles[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
