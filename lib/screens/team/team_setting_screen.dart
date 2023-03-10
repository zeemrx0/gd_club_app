import 'package:flutter/material.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class TeamSettingScreen extends StatelessWidget {
  static const routeName = '/team-setting';

  const TeamSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final bool isUserOwner = arguments['isUserOwner'] as bool;

    final Team team = arguments['team'] as Team;

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Chỉnh sửa',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {},
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
                  children: [
                    Icon(
                      Icons.edit_note,
                      color: Colors.amber[700],
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Chỉnh sửa thông tin nhóm',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!isUserOwner)
              GestureDetector(
                onTap: () async {
                  Provider.of<Auth>(context, listen: false)
                      .currentUser
                      .leaveATeam(team.id, context);

                  Navigator.of(context).pop();
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
                    children: [
                      Icon(
                        Ionicons.exit,
                        color: Colors.red[500],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Rời nhóm',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isUserOwner)
              GestureDetector(
                onTap: () async {
                  Provider.of<Auth>(context, listen: false)
                      .currentUser
                      .deleteATeam(context, teamId: team.id);

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.trash_bin,
                        color: Colors.red[500],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Xóa nhóm',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
