import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/screens/account/account_screen.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:gd_club_app/screens/event/event_detail_screen.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';
import 'package:gd_club_app/screens/event/event_information_screen.dart';
import 'package:gd_club_app/screens/event/event_qr_code_screen.dart';
import 'package:gd_club_app/screens/event/manage_events_screen.dart';
import 'package:gd_club_app/screens/event/events_screen.dart';
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
          create: (context) => Auth(),
        ),
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
          ManageEventsScreen.routeName: (context) =>
              AuthStreamBuilder(child: ManageEventsScreen()),
          EventInformationScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventInformationScreen()),
          EventDetailScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventDetailScreen()),
          EditEventScreen.routeName: (context) =>
              AuthStreamBuilder(child: EditEventScreen()),
          EventQRCodeScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventQRCodeScreen()),
          AccountScreen.routeName: (context) =>
              AuthStreamBuilder(child: AccountScreen()),
        },
      ),
    );
  }
}
