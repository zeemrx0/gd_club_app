import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
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
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return ChangeNotifierProvider.value(
      value: event,
      child: Consumer<Event>(
        builder: (context, value, child) => Scaffold(
          // appBar: AppBar(
          //   title: Text(value.title),
          // ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                GlassAppBar(),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      GlassCard(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Thời gian',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(DateFormat.jm()
                                  .add_yMd()
                                  .format(value.dateTime)),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const Text(
                                'Địa điểm',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(value.location),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const Text(
                                'Mô tả',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(value.description ?? ''),
                            ],
                          ),
                        ),
                      ),
                      if (value.isRegistered)
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
                      if (value.isRegistered)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: Colors.grey[500],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            value.toggleRegistered();
                          },
                          child: const Text(
                            'Hủy đăng kí',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (!value.isRegistered)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: Colors.green[600],
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            value.toggleRegistered();
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
        ),
      ),
    );
  }
}
