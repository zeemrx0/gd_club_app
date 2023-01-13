import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "/account";

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản"),
      ),
      body: Card(
        margin: const EdgeInsets.all(12),
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
                        backgroundImage: NetworkImage(user.imageUrl!),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(user.name!),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
