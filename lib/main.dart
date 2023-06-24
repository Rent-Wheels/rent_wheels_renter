import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car_page_one.dart';

import 'package:rent_wheels_renter/tester.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/users/methods/user_methods.dart';

import 'package:rent_wheels_renter/src/home/presentation/home.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';
import 'package:rent_wheels_renter/src/verify/presentation/verify_user.dart';
import 'package:rent_wheels_renter/src/verify/presentation/verify_email.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentWheels Renter',
      home: AddCarPageOne(),
    );
  }
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool isRenter = false;
  userStatus() async {
    await AuthService.firebase().initialize();

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
            if (global.user != null) {
              if (!isRenter) return const VerifyUser();
              if (global.user!.emailVerified) {
                return const Home();
              }
              return const VerifyEmail();
            } else {
              return const Login();
            }

          default:
            return const Tester();
        }
      },
    );
  }
}
