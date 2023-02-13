import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event/event_qr_code_screen.dart';
import 'package:gd_club_app/widgets/glass_app_bar.dart';
import 'package:gd_club_app/widgets/glass_card.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventRegistrationInformationScreen extends StatefulWidget {
  static const routeName = '/event-information';

  @override
  State<EventRegistrationInformationScreen> createState() =>
      _EventRegistrationInformationScreenState();
}

class _EventRegistrationInformationScreenState
    extends State<EventRegistrationInformationScreen> {
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
            const GlassAppBar(),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: event.imageUrls.isNotEmpty
                          ? Image.network(
                              event.imageUrls[0],
                              fit: BoxFit.cover,
                            )
                          : GlassCard(
                              child: Center(
                                child: Text(
                                  'Chưa có hình ảnh',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GlassCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thời gian',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat.jm().add_yMd().format(event.dateTime),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Địa điểm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Mô tả',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            (event.description != null &&
                                    event.description != '')
                                ? event.description!
                                : '(Không có mô tả)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (event.isRegistered)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EventQRCodeScreen.routeName);
                      },
                      child: const Text(
                        'Check in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (event.isRegistered)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.grey[500],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Provider.of<Events>(context, listen: false)
                            .toggleEventRegisteredStatus(event.id!);
                      },
                      child: const Text(
                        'Hủy đăng kí',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (!event.isRegistered)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Provider.of<Events>(context, listen: false)
                            .toggleEventRegisteredStatus(event.id!);
                      },
                      child: const Text(
                        'Đăng kí',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
