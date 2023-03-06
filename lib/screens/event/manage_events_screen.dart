import 'package:flutter/material.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
import 'package:gd_club_app/widgets/events/event_item.dart';
import 'package:ionicons/ionicons.dart';

import 'package:provider/provider.dart';

class ManageEventsScreen extends StatelessWidget {
  static const routeName = '/manage-events';

  @override
  Widget build(BuildContext context) {
    final Organizer organizer =
        ModalRoute.of(context)!.settings.arguments as Team;

    final managedEvents =
        Provider.of<Events>(context).findEventsByOrganizerId(organizer.id);

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: Column(
        children: [
          CustomAppBar(
            title: Text(
              organizer.name,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditEventScreen.routeName,
                    arguments: {
                      'organizer': organizer,
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Ionicons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: managedEvents.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: EventItem(
                      event: managedEvents[index],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
