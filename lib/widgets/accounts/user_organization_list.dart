import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/organization.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/organizations.dart';
import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:provider/provider.dart';

class UserOrganizationList extends StatefulWidget {
  final Account account;
  const UserOrganizationList(this.account, {super.key});

  @override
  State<UserOrganizationList> createState() => _UserOrganizationListState();
}

class _UserOrganizationListState extends State<UserOrganizationList> {
  @override
  Widget build(BuildContext context) {
    final List<Organization> organizationList = [];

    (widget.account as User).participations.forEach((key, value) async {
      final Organization? organization =
          Provider.of<Organizations>(context).findOrganizationById(key);
      if (organization != null) {
        organizationList.add(organization);
      }
    });

    return Container(
      margin: const EdgeInsets.all(12),
      child: GlassCard(
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Câu lạc bộ của bạn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ...organizationList.map(
                  (organization) => Row(
                    children: [
                      SizedBox(
                        width: 44,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: (organization.avatarUrl != null)
                                ? Image.network(
                                    organization.avatarUrl!,
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
                        organization.name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
