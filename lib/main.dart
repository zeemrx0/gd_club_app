import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:gd_club_app/screens/events_managing_screen.dart';
import 'package:gd_club_app/screens/events_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appFuture = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Events(),
        ),
      ],
      child: FutureBuilder(
        future: _appFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Xảy ra lỗi rùi, thử lại nhaa :<'),
            );
          }

          return MaterialApp(
            title: 'Sắc màu Gia Định',
            localizationsDelegates: [GlobalMaterialLocalizations.delegate],
            supportedLocales: const [
              Locale('vn'),
              Locale('en', 'US'),
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: EventsScreen(),
            routes: {
              EventsScreen.routeName: (context) => EventsScreen(),
              EventsManagingScreen.routeName: (context) =>
                  EventsManagingScreen(),
              EventDetailScreen.routeName: (context) => EventDetailScreen(),
              EventEditScreen.routeName: (context) => EventEditScreen(),
            },
          );
        },
      ),
    );
  }
}
