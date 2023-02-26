import 'package:flutter/material.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/screens/team/team_detail_screen.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  final String role;
  const TeamCard({required this.team, required this.role});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          TeamDetailScreen.routeName,
          arguments: team.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
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
              width: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: (team.avatarUrl != null)
                      ? Image.network(
                          team.avatarUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/event_illustration.jpeg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              team.name,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
