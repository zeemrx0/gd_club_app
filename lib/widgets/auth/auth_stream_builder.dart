import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class AuthStreamBuilder extends StatelessWidget {
  final Widget child;

  const AuthStreamBuilder({required this.child});

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     // if (snapshot.hasData) {
    //     //   Provider.of<Auth>(context, listen: false).fetchAccountData();

    //     //   return child;
    //     // }

    //     return const AuthScreen();
    //   },
    // );

    return FutureBuilder(
      future: Provider.of<Auth>(context, listen: false).isAuth(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const AuthScreen();
        }

        final bool isAuth = snapshot.data!;

        if (isAuth) {
          return child;
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
