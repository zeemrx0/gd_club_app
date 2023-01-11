import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:gd_club_app/screens/event_detail_screen.dart';
import 'package:gd_club_app/screens/event_edit_screen.dart';
import 'package:gd_club_app/screens/event_information_screen.dart';
import 'package:gd_club_app/screens/event_qr_code_screen.dart';
import 'package:gd_club_app/screens/events_managing_screen.dart';
import 'package:gd_club_app/screens/events_screen.dart';
import 'package:gd_club_app/screens/home_screen.dart';
import 'package:gd_club_app/widgets/auth/auth_stream_builder.dart';
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
              return AuthStreamBuilder(child: HomeScreen());
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
          EventsScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventsScreen()),
          EventsManagingScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventsManagingScreen()),
          EventInformationScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventInformationScreen()),
          EventDetailScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventDetailScreen()),
          EventEditScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventEditScreen()),
          EventQRCodeScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventQRCodeScreen()),
        },
      ),
    );
  }
}
