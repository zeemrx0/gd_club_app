import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:gd_club_app/screens/events_managing_screen.dart';
import 'package:gd_club_app/screens/events_screen.dart';
import 'package:provider/provider.dart';

void main() async {
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
      child: MaterialApp(
        title: 'Sắc màu Gia Định',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [
          Locale('vn'),
          Locale('en', 'US'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _appFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return EventsScreen();
                  }

                  return AuthScreen();
                },
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text('Lỗi rùi :< Thử lại nhaa'),
            );
          },
        ),
        routes: {
          EventsScreen.routeName: (context) => EventsScreen(),
          EventsManagingScreen.routeName: (context) => EventsManagingScreen(),
          EventDetailScreen.routeName: (context) => EventDetailScreen(),
          EventEditScreen.routeName: (context) => EventEditScreen(),
        },
      ),
    );
  }
}
