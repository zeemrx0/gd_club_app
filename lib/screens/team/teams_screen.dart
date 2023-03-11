import 'package:flutter/material.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/team/team_editing_screen.dart';
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
    final User currentAccount = Provider.of<Auth>(context).currentUser!;
    final TextEditingController teamCodeController = TextEditingController();

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
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                TeamEditingScreen.routeName);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
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
                              child: Text(
                                'Tạo đội nhóm của bạn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Hoặc',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Tham gia bằng lời mời',
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Tên đội nhóm',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          controller: teamCodeController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Provider.of<Auth>(context, listen: false)
                                .currentUser!
                                .joinATeam(teamCodeController.text, context);
                            teamCodeController.clear();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
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
                              child: Text(
                                'Tham gia',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
