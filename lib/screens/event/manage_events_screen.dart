import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';
import 'package:gd_club_app/widgets/app_drawer.dart';
import 'package:gd_club_app/widgets/events/event_item.dart';

import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:provider/provider.dart';

class ManageEventsScreen extends StatelessWidget {
  static const routeName = '/manage-events';

  @override
  Widget build(BuildContext context) {
    final managedEvents = Provider.of<Events>(context).managedEvents;

    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: const AppDrawer(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: ListView.builder(
                    itemCount: managedEvents.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(
                        bottom: 6,
                      ),
                      child: EventItem(
                        isEdit: true,
                        event: managedEvents[index],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
