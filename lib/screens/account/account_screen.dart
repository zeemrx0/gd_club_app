import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
import 'package:gd_club_app/widgets/accounts/user_organization_list.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/glass_app_bar.dart';
import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Auth>(context, listen: false).account;

    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: const AppDrawer(),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const GlassAppBar(),
            Container(
              margin: const EdgeInsets.all(12),
              child: GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: account!.avatarUrl != null
                                ? NetworkImage(account.avatarUrl!)
                                : null,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            account.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EditAccountScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (account.systemRole == 'User') UserOrganizationList(account),
          ],
        ),
      ),
    );
  }
}
