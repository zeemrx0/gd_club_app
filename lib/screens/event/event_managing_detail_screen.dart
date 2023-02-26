import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';

import 'package:gd_club_app/widgets/glass_card.dart';
import 'package:provider/provider.dart';

class EventManagingDetailScreen extends StatefulWidget {
  static const routeName = '/event-detail';

  @override
  State<EventManagingDetailScreen> createState() =>
      _EventManagingDetailScreenState();
}

class _EventManagingDetailScreenState extends State<EventManagingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as String;

    final event = Provider.of<Events>(context).findEventById(eventId);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Số người đã đăng kí:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${event.numberOfRegistrations}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(
                                    //     EventQRCodeScreen.routeName,
                                    //     arguments: event);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Check in',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blue[300],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        EditEventScreen.routeName,
                                        arguments: event);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Chỉnh sửa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
