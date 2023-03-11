import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
import 'package:gd_club_app/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Auth>(context, listen: false).currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 32,
                          backgroundImage: currentUser!.avatarUrl != null
                              ? NetworkImage(currentUser.avatarUrl!)
                              : null,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          currentUser.name,
                          style: const TextStyle(
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
                      ),
                    )
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
