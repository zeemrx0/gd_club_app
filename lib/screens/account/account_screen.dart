import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "/account";

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(102, 255, 255, 255),
                      Color.fromARGB(26, 255, 255, 255),
                    ],
                  ),
                  border: const GradientBoxBorder(
                    width: 2,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(102, 255, 255, 255),
                        Color.fromARGB(26, 255, 255, 255),
                      ],
                    ),
                  ),
                ),
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
                                backgroundImage: user!.imageUrl != null
                                    ? NetworkImage(user.imageUrl!)
                                    : null,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(user.name),
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
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
