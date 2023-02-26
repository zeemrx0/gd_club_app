import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/providers/organizers.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/providers/users.dart';
import 'package:gd_club_app/screens/account/account_screen.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
import 'package:gd_club_app/screens/event/edit_event_screen.dart';
import 'package:gd_club_app/screens/event/event_managing_detail_screen.dart';
import 'package:gd_club_app/screens/event/event_qr_code_screen.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:gd_club_app/screens/event/manage_events_screen.dart';
import 'package:gd_club_app/screens/home_screen.dart';
import 'package:gd_club_app/screens/team/team_detail_screen.dart';
import 'package:gd_club_app/screens/team/teams_screen.dart';
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
          create: (context) => Teams(),
        ),
        ChangeNotifierProvider(
          create: (context) => Users(),
        ),
        ChangeNotifierProxyProvider2<Users, Teams, Organizers>(
          create: (context) => Organizers(null, null),
          update: (context, usersProvider, teamsProvider, previous) =>
              Organizers(usersProvider, teamsProvider),
        ),
        ChangeNotifierProvider(
          create: (context) => Registrations(),
        ),
        ChangeNotifierProxyProvider2<Registrations, Organizers, Events>(
          create: (context) => Events(null, null),
          update: (
            context,
            registrationsProvider,
            organizersProvider,
            previousEvents,
          ) =>
              previousEvents != null
                  ? (previousEvents
                    ..update(registrationsProvider, organizersProvider))
                  : Events(registrationsProvider, organizersProvider),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sắc màu Gia Định',
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [
          Locale('vn'),
          Locale('en', 'US'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
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
          HomeScreen.routeName: (context) => AuthStreamBuilder(
                child: HomeScreen(),
              ),
          ManageEventsScreen.routeName: (context) =>
              AuthStreamBuilder(child: ManageEventsScreen()),
          EventRegistrationInformationScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventRegistrationInformationScreen()),
          EventManagingDetailScreen.routeName: (context) =>
              AuthStreamBuilder(child: EventManagingDetailScreen()),
          EditEventScreen.routeName: (context) =>
              AuthStreamBuilder(child: EditEventScreen()),
          EventQRCodeScreen.routeName: (context) =>
              const AuthStreamBuilder(child: EventQRCodeScreen()),
          AccountScreen.routeName: (context) =>
              AuthStreamBuilder(child: AccountScreen()),
          EditAccountScreen.routeName: (context) => const EditAccountScreen(),
          TeamsScreen.routeName: (context) => const AuthStreamBuilder(
                child: TeamsScreen(),
              ),
          TeamDetailScreen.routeName: (context) => const AuthStreamBuilder(
                child: TeamDetailScreen(),
              ),
        },
      ),
    );
  }
}
