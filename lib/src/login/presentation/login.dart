import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/auth_textfields.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          buildAuthTextFields(
            label: 'Email',
            controller: emailController,
          )
        ],
      )),
    );
  }
}
