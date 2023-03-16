import 'package:flutter/material.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';

class AccountEditingScreen extends StatelessWidget {
  static const routeName = '/edit-account';

  const AccountEditingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Chỉnh sửa tài khoản",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
