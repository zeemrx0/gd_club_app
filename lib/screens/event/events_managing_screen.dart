import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/screens/event/event_edit_screen.dart';

import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/events/event_list.dart';

class EventsManagingScreen extends StatelessWidget {
  static const routeName = "/events-managing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: EventList(
          isManaging: true,
        ),
      ),
      appBar: AppBar(
        title: const Text('Quản lý sự kiện'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EventEditScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
