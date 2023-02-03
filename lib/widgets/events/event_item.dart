import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/materials/custom_decoration.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:gd_club_app/screens/event/event_managing_detail_screen.dart';
import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final bool isEdit;

  EventItem({required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);

    return GestureDetector(
      onTap: () {
        if (isEdit) {
          Navigator.of(context).pushNamed(
            EventManagingDetailScreen.routeName,
            arguments: event.id,
          );
        } else {
          Navigator.of(context).pushNamed(
            EventRegistrationInformationScreen.routeName,
            arguments: event,
          );
        }
      },
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 66,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      (event.imageUrls.isNotEmpty)
                          ? event.imageUrls[0]
                          : "https://img.freepik.com/free-vector/time-management-calendar-method-appointment-planning-business-organizer-people-drawing-mark-work-schedule-cartoon-characters-colleagues-teamwork_335657-2096.jpg?w=2000",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    event.organizerName,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat.jm().add_yMd().format(event.dateTime),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    event.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
