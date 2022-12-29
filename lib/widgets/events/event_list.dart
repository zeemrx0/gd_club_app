import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/widgets/events/event_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<Events>(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: events.allEvents.length,
      itemBuilder: (context, i) {
        return EventItem(events.allEvents[i]);
      },
    );
  }
}
