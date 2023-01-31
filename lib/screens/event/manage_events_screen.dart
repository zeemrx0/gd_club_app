import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';

import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/events/event_list.dart';

class ManageEventsScreen extends StatelessWidget {
  static const routeName = "/manage-events";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: EventList(
            isManaging: true,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Quản lý sự kiện'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditEventScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
