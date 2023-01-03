import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
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
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return ChangeNotifierProvider.value(
      value: event,
      child: Consumer<Event>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(value.title),
          ),
          body: Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EventEditScreen.routeName, arguments: value);
                  },
                  child: const Text('Chỉnh sửa'),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
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
                              '${value.noRegisters}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
