import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/widgets/events/event_card.dart';
import 'package:provider/provider.dart';

class TrendingEventList extends StatefulWidget {
  const TrendingEventList({super.key});

  @override
  State<TrendingEventList> createState() => _TrendingEventListState();
}

class _TrendingEventListState extends State<TrendingEventList> {
  @override
  Widget build(BuildContext context) {
    var events = Provider.of<Events>(context).allEvents;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: ChangeNotifierProvider.value(
              value: events[i],
              child: EventCard(),
            ),
          );
        },
      ),
    );
  }
}
