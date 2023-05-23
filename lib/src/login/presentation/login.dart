import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/src/home/presentation/home.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          buildGenericButtonWidget(
              buttonName: 'Login',
              onPressed: () async {
                final credential =
                    await AuthService.firebase().signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );

                global.accessToken = await credential.user!.getIdToken();

                debugPrint(global.accessToken);
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (route) => false);
              })
        ],
      )),
    );
  }
}
