import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/event_edit_screen.dart';
import 'package:gd_club_app/screens/event/event_qr_code_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  static const routeName = '/event-detail';

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as String;

    final event = Provider.of<Events>(context).findEventById(eventId);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 8.0),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${event.noRegisters}',
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
                                color: Theme.of(context).primaryColor),
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
                              EventEditScreen.routeName,
                              arguments: event);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Chỉnh sửa',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.orange),
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
    );
  }
}
