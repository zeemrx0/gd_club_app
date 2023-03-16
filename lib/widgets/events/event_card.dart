import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:intl/intl.dart' show DateFormat;

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          EventRegistrationInformationScreen.routeName,
          arguments: event.id,
        );
      },
      child: Container(
        width: 200,
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 200 / 120,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              event.organizer?.avatarUrl ??
                                  'https://img.freepik.com/free-vector/people-putting-puzzle-pieces-together_52683-28610.jpg?w=2000&t=st=1677315161~exp=1677315761~hmac=4a5f3a94713bed9e59bb8217504922d76f449947872c47739f0a1b046b553391',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        event.organizer?.name ?? '',
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
                    height: 2,
                  ),
                  Text(
                    event.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat.jm().add_yMd().format(event.dateTime),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  if (!event.isRegistered)
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple[300]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size.zero,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                        ),
                      ),
                      child: const Text(
                        'Đăng kí ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (event.isRegistered)
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple[200]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size.zero,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                        ),
                      ),
                      child: const Text(
                        'Đã đăng kí',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
