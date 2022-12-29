import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final event;

  EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(event.title),
          subtitle: Text(
            '${DateFormat.jm().add_yMd().format(event.dateTime)} - ${event.address}',
          ),
          trailing: event.isRegistered
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const SizedBox(),
          onTap: () {
            Navigator.of(context)
                .pushNamed(EventDetailScreen.routeName, arguments: event);
          },
        ),
      ),
    );
  }
}
