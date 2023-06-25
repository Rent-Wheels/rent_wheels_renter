import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/src/signup/presentation/signup.dart';
import 'package:string_validator/string_validator.dart';

class LoginMock extends StatefulWidget {
  const LoginMock({super.key});

  @override
  State<LoginMock> createState() => _LoginMockState();
}

class _LoginMockState extends State<LoginMock> {
  bool isEmailValid = false;
  bool isPasswordValid = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isActive() {
    return isEmailValid && isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Rent Wheels',
              style: heading3Information,
            ),
            Space().height(context, 0.01),
            const Text(
              'Enter your account details to continue.',
              style: body2Neutral,
            ),
            Space().height(context, 0.03),
            buildGenericTextfield(
              maxLines: 1,
              context: context,
              controller: email,
              hint: 'Email Address',
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
            Space().height(context, 0.02),
            buildGenericTextfield(
              maxLines: 1,
              hint: 'Password',
              context: context,
              isPassword: true,
              controller: password,
              textCapitalization: TextCapitalization.none,
              onChanged: (value) {
                if (isAscii(value) && value.length > 5) {
                  setState(() {
                    isPasswordValid = true;
                  });
                } else {
                  setState(() {
                    isPasswordValid = false;
                  });
                }
              },
            ),
            Space().height(context, 0.05),
            buildGenericButtonWidget(
              context: context,
              buttonName: 'Login',
              isActive: isActive(),
              width: Sizes().width(context, 0.85),
              onPressed: () {},
            ),
            Space().height(context, 0.02),
            SizedBox(
              width: Sizes().width(context, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordMock(),
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: body2Neutral,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: Sizes().height(context, 0.1),
        color: rentWheelsNeutralLight0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: body2Neutral,
            ),
            Space().width(context, 0.01),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
              child: const Text(
                "Register",
                style: heading6InformationBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordMock extends StatefulWidget {
  const ForgotPasswordMock({super.key});

  @override
  State<ForgotPasswordMock> createState() => _ForgotPasswordMockState();
}

class _ForgotPasswordMockState extends State<ForgotPasswordMock> {
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
