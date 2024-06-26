import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/firebase_options.dart';
import 'package:rent_wheels_renter/injection.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rent_wheels_renter/src/mainSection/base.dart';
import 'package:rent_wheels_renter/src/loading/loading_screen.dart';
import 'package:rent_wheels_renter/src/onboarding/presentation/onboarding.dart';
import 'package:rent_wheels_renter/src/authentication/login/presentation/login.dart';
import 'package:rent_wheels_renter/src/authentication/verify/presentation/verify_email.dart';
import 'package:rent_wheels_renter/src/authentication/upgrade/presentation/upgrade_to_renter.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/users/methods/user_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rent Wheels Renter',
      home: ConnectionPage(),
    ),
  );
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool isRenter = false;
  bool firstTime = true;
  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTime')!;
  }

  userStatus() async {
    await AuthService.firebase().initialize();
    firstTime = await getOnboardingStatus();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await global.setGlobals(currentUser: user);

      final userDetails = await RentWheelsUserMethods()
          .getUserDetails(userId: global.user!.uid);

      await global.setGlobals(fetchedUserDetails: userDetails);

      if (userDetails.role == Roles.renter.id) {
        isRenter = true;
      }
    }

    return isRenter;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userStatus(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (firstTime) {
              return const OnboardingScreen();
            } else if (global.user != null) {
              if (!isRenter) return const UpgradeUser();
              if (global.user!.emailVerified) {
                return const MainSection();
              }
              return const VerifyEmail();
            } else {
              return const Login();
            }

          default:
            return const LoadingScreen();
        }
      },
    );
  }
}
