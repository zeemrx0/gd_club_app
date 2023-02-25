import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/widgets/events/event_card.dart';

class RecommendedEventsList extends StatelessWidget {
  final List<Event> _events;
  const RecommendedEventsList(this._events);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        children: [
          ..._events.map(
            (event) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                child: EventCard(
                  event: event,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
