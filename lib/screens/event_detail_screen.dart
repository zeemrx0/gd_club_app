import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-detail';

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
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
                    Text(DateFormat.jm().add_yMd().format(event.dateTime)),
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
                    Text(event.location),
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
                    Text(event.description ?? ''),
                  ],
                ),
              ),
            ),
            if (event.isRegistered)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
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
                onPressed: () {},
                child: const Text(
                  'Đăng kí',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
      ),
    );
  }
}
