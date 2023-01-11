import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Events>(context, listen: false).fetchEvents();

    return Scaffold(
      body: Text('test'),
      appBar: AppBar(
        title: const Text('Sắc màu Gia Định'),
      ),
      drawer: AppDrawer(),
    );
  }
}
