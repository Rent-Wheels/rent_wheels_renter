import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/src/login/presentation/login.dart';
import 'package:rent_wheels_renter/src/upgrade/presentation/upgrade_to_renter.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/src/home/presentation/home.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().height(context, 0.01)),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: rentWheelsErrorDark700,
              ),
              onPressed: () async {
                buildLoadingIndicator(context, 'Logging Out');

                try {
                  await AuthService.firebase().logout();
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  showErrorPopUp(e.toString(), context);
                }
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/email-sent.jpg',
              width: Sizes().width(context, 0.5),
            ),
            Space().height(context, 0.02),
            const Text(
              'Verify your email address',
              style: heading3Information,
            ),
            Space().height(context, 0.02),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'A verification email has been sent to ',
                children: [
                  TextSpan(
                    text: '${global.user!.email}',
                    style: heading5Information,
                  ),
                ],
                style: body1Information,
              ),
            ),
            Space().height(context, 0.03),
            buildGenericButtonWidget(
                width: Sizes().width(context, 0.5),
                isActive: true,
                context: context,
                btnColor: rentWheelsSuccessDark700,
                buttonName: 'Confirm Verification',
                onPressed: () async {
                  buildLoadingIndicator(context, '');
                  try {
                    await FirebaseAuth.instance.currentUser!.reload();

                    global.user = FirebaseAuth.instance.currentUser;

                    if (!global.user!.emailVerified) {
                      throw Exception('Email not verified.');
                    }

                    final user = await RentWheelsUserMethods()
                        .getUserDetails(userId: global.user!.uid);

                    if (!mounted) return;
                    Navigator.pop(context);

                    if (user.role == Roles.renter.id) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpgradeUser(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    if (!mounted) return;
                    Navigator.pop(context);
                    showErrorPopUp(e.toString(), context);
                  }
                }),
            Space().height(context, 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive an email?",
                  style: body2Neutral,
                ),
                Space().width(context, 0.01),
                GestureDetector(
                  onTap: () async {
                    buildLoadingIndicator(context, '');
                    try {
                      await AuthService.firebase()
                          .verifyEmail(user: global.user!);

                      if (!mounted) return;
                      Navigator.pop(context);
                      showSuccessPopUp('Email Verification Sent', context);
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.pop(context);
                      showErrorPopUp(e.toString(), context);
                    }
                  },
                  child: const Text(
                    "Resend Email",
                    style: heading6InformationBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
