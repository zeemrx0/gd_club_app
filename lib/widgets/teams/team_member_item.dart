import 'package:flutter/material.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/providers/users.dart';
import 'package:provider/provider.dart';

class TeamMemberItem extends StatelessWidget {
  final String memberId;
  final List<Role> memberRoles;
  const TeamMemberItem(this.memberId, this.memberRoles, {super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).findUserById(memberId);
    print(user?.id);

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(
        //   TeamDetailScreen.routeName,
        //   arguments: team.id,
        // );
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
                  child: (user!.avatarUrl != null)
                      ? Image.network(
                          user.avatarUrl!,
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
              user.name,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
