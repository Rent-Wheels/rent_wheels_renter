import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/src/home/presentation/home.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('A verification email has been sent to ${global.user!.email} '),
          // buildGenericButtonWidget(
          //     buttonName: 'Confirm Verification',
          //     onPressed: () async {
          //       await FirebaseAuth.instance.currentUser!.reload();

          //       global.user = FirebaseAuth.instance.currentUser;

          //       if (!global.user!.emailVerified) return;

          //       final user = await RentWheelsUserMethods()
          //           .getUserDetails(userId: global.user!.uid);
          //       if (!mounted) return;

          //       if (user.role == Roles.renter.id) {
          //         Navigator.of(context).pushAndRemoveUntil(
          //             MaterialPageRoute(builder: (context) => const Home()),
          //             (route) => false);
          //       }
          //     }),
          // buildGenericButtonWidget(
          //   buttonName: 'Resend Verification',
          //   onPressed: () async {
          //     await AuthService.firebase().verifyEmail(user: global.user!);
          //   },
          // ),
        ],
      ),
    );
  }
}
