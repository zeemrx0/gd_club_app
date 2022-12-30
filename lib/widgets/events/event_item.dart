import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final bool isEdit;

  EventItem(this.event, {required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(event.title),
          subtitle: Text(
            '${DateFormat.jm().add_yMd().format(event.dateTime)} - ${event.location}',
          ),
          trailing: event.isRegistered
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const SizedBox(),
          onTap: () {
            if (isEdit) {
              Navigator.of(context)
                  .pushNamed(EventEditScreen.routeName, arguments: event);
            } else {
              Navigator.of(context)
                  .pushNamed(EventDetailScreen.routeName, arguments: event);
            }
          },
        ),
      ),
    );
  }
}
