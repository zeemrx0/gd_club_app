import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
