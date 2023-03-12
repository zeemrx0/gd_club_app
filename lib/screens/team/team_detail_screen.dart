import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/screens/event/managing_event_list_screen.dart';
import 'package:gd_club_app/screens/team/managing_member_list_screen.dart';
import 'package:gd_club_app/screens/team/team_setting_screen.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class TeamDetailScreen extends StatelessWidget {
  static const routeName = '/team-detail';
  const TeamDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String teamId = arguments['teamId'] as String;
    final String userId = Provider.of<Auth>(context).currentUser!.id;

    final Team team =
        Provider.of<Teams>(context, listen: false).findTeamById(teamId)!;

    final List<Role> roles = arguments['roles'] as List<Role>;

    bool isUserManager = false;
    bool isUserOwner = false;

    for (final role in roles) {
      if (role.isManager) {
        isUserManager = true;
      }

      if (role.isOwner) {
        isUserOwner = true;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: const CustomAppBar(
        title: Text(
          'Quản lý sự kiện',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
              children: [
                SizedBox(
                  width: 100,
                  child: ClipRRect(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: team.avatarUrl != null
                          ? Image.network(
                              team.avatarUrl!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      team.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          // Show managing dashboard if user is a manager
          if (isUserManager)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ManagingEventListScreen.routeName,
                        arguments: team,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Ionicons.calendar,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Quản lí sự kiện',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            FluentSystemIcons.ic_fluent_organization_filled,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Quản lí chức vụ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ManagingMemberListScreen.routeName,
                        arguments: team.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                          ),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Ionicons.people,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Quản lí thành viên',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        TeamSettingScreen.routeName,
                        arguments: {
                          'isUserOwner': isUserOwner,
                          'team': team,
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(
                            Ionicons.settings,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Chỉnh sửa',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
