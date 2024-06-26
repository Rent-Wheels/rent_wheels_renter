import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/src/authentication/resetPassword/presentation/reset_password_success.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/auth/auth_exceptions.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailValid = false;

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        foregroundColor: rentWheelsBrandDark900,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password?',
              style: heading3Information,
            ),
            Space().height(context, 0.01),
            const Text(
              'Please enter your email to recover your account.',
              style: body2Neutral,
            ),
            Space().height(context, 0.03),
            buildGenericTextfield(
              maxLines: 1,
              context: context,
              controller: email,
              hint: 'Email Address',
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              onChanged: (value) {
                if (isEmail(value)) {
                  setState(() {
                    isEmailValid = true;
                  });
                } else {
                  setState(() {
                    isEmailValid = false;
                  });
                }
              },
            ),
            Space().height(context, 0.05),
            buildGenericButtonWidget(
              context: context,
              buttonName: 'Recover Account',
              isActive: isEmailValid,
              width: Sizes().width(context, 0.85),
              onPressed: () async {
                buildLoadingIndicator(context, '');
                try {
                  await AuthService.firebase().resetPassword(email: email.text);

                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          ResetPasswordSuccess(email: email.text),
                    ),
                    (route) => false,
                  );
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  if (e is GenericAuthException) {
                  } else {
                    showErrorPopUp(
                      e.toString(),
                      context,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
