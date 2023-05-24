import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildGenericButtonWidget(
              buttonName: 'Logout',
              onPressed: () async {
                await AuthService.firebase().logout();
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false);
              },
            ),
            buildGenericButtonWidget(
                buttonName: 'Delete Account',
                onPressed: () async {
                  await AuthService.firebase()
                      .deleteUser(user: FirebaseAuth.instance.currentUser!);

                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
