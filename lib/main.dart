import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/events_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Events(),
        ),
      ],
      child: MaterialApp(
        title: 'Sắc màu Gia Định',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EventsScreen(),
        routes: {
          EventsScreen.routeName: (context) => EventsScreen(),
          EventDetailScreen.routeName: (context) => EventDetailScreen(),
        },
      ),
    );
  }
}
