import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:gd_club_app/screens/event_information_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final bool isEdit;

  EventItem({required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(event.title),
          subtitle: Text(
            '${DateFormat.jm().add_yMd().format(event.dateTime)} - ${event.location}',
          ),
          trailing: Consumer<Event>(
            builder: (context, value, child) => event.isRegistered && !isEdit
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const SizedBox(),
          ),
          onTap: () {
            if (isEdit) {
              Navigator.of(context)
                  .pushNamed(EventDetailScreen.routeName, arguments: event);
            } else {
              Navigator.of(context).pushNamed(EventInformationScreen.routeName,
                  arguments: event);
            }
          },
        ),
      ),
    );
  }
}
