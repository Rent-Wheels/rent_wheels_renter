import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';

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
        child: Center(
          child: buildGenericButtonWidget(
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
        ),
      ),
    );
  }
}
