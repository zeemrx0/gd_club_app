import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';
import 'package:gd_club_app/widgets/custom_app_bar.dart';
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
    final String eventId = ModalRoute.of(context)!.settings.arguments as String;

    final Event? event =
        Provider.of<Events>(context, listen: false).findEventById(eventId);

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Container(
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
                                  style: TextStyle(),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${event!.registrations.length}',
                                  style: const TextStyle(),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                                    arguments: {
                                      'event': event,
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Chỉnh sửa',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
    );
  }
}
