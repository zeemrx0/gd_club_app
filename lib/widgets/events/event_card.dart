import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          EventRegistrationInformationScreen.routeName,
          arguments: event.id,
        );
      },
      child: GlassCard(
        child: Container(
          width: 156,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: (event.imageUrls.isNotEmpty)
                      ? Image.network(
                          event.imageUrls[0],
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/event_illustration.jpeg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      event.organizationName,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
