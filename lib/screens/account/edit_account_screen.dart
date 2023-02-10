import 'package:flutter/material.dart';

class EditAccountScreen extends StatelessWidget {
  static const routeName = '/edit-account';

  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa tài khoản'),
      ),
    );
  }
}
