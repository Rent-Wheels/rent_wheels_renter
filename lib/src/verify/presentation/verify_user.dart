import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You are not a renter'),
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
              })
        ],
      ),
    );
  }
}
