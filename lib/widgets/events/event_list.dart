import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/events_managing_screen.dart';
import 'package:gd_club_app/widgets/events/event_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventList extends StatefulWidget {
  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  void initState() {
    Provider.of<Events>(context, listen: false).fetchEvents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<Events>(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: events.allEvents.length,
      itemBuilder: (context, i) {
        return EventItem(
          events.allEvents[i],
          isEdit: ModalRoute.of(context)!.settings.name ==
              EventsManagingScreen.routeName,
        );
      },
    );
  }
}
