import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/providers/memberships.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/providers/users.dart';
import 'package:gd_club_app/screens/account/account_screen.dart';
import 'package:gd_club_app/screens/account/edit_account_screen.dart';
import 'package:gd_club_app/screens/auth_screen.dart';
import 'package:gd_club_app/screens/event/event_editing_screen.dart';
import 'package:gd_club_app/screens/event/event_managing_detail_screen.dart';
import 'package:gd_club_app/screens/event/event_qr_code_screen.dart';
import 'package:gd_club_app/screens/event/event_registration_detail_screen.dart';
import 'package:gd_club_app/screens/event/managing_event_list_screen.dart';
import 'package:gd_club_app/screens/home_screen.dart';
import 'package:gd_club_app/screens/team/managing_member_list_screen.dart';
import 'package:gd_club_app/screens/team/team_detail_screen.dart';
import 'package:gd_club_app/screens/team/team_editing_screen.dart';
import 'package:gd_club_app/screens/team/team_setting_screen.dart';
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
        ChangeNotifierProvider<Memberships>(
          create: (context) => Memberships(),
        ),
        ChangeNotifierProvider(
          create: (context) => Registrations(),
        ),
        ChangeNotifierProvider<Events>(
          create: (context) => Events(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
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
                return AuthStreamBuilder(
                  child: auth.currentUser == null ? AuthScreen() : HomeScreen(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          routes: {
            HomeScreen.routeName: (context) => AuthStreamBuilder(
                  child: HomeScreen(),
                ),
            ManagingEventListScreen.routeName: (context) =>
                AuthStreamBuilder(child: ManagingEventListScreen()),
            EventRegistrationInformationScreen.routeName: (context) =>
                AuthStreamBuilder(child: EventRegistrationInformationScreen()),
            EventManagingDetailScreen.routeName: (context) =>
                AuthStreamBuilder(child: EventManagingDetailScreen()),
            EventEditingScreen.routeName: (context) =>
                AuthStreamBuilder(child: EventEditingScreen()),
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
            TeamEditingScreen.routeName: (context) => const AuthStreamBuilder(
                  child: TeamEditingScreen(),
                ),
            ManagingMemberListScreen.routeName: (context) =>
                const AuthStreamBuilder(
                  child: ManagingMemberListScreen(),
                ),
            TeamSettingScreen.routeName: (context) => const AuthStreamBuilder(
                  child: TeamSettingScreen(),
                ),
          },
        ),
      ),
    );
  }
}
