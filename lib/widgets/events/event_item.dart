import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/providers/organizers.dart';
import 'package:gd_club_app/screens/event/event_managing_detail_screen.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:gd_club_app/widgets/shadow_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final Organizer organizer = Provider.of<Organizers>(context)
        .findOrganizerById(event.organizer!.id)!;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          EventManagingDetailScreen.routeName,
          arguments: event.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              child: ClipRRect(
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
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(
                          organizer.avatarUrl ??
                              'https://img.freepik.com/free-vector/people-putting-puzzle-pieces-together_52683-28610.jpg?w=2000&t=st=1677315161~exp=1677315761~hmac=4a5f3a94713bed9e59bb8217504922d76f449947872c47739f0a1b046b553391',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      organizer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  DateFormat.jm().add_yMd().format(event.dateTime),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  event.location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
