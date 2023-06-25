import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/profilePicture/profile_picture_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';

class SignUpMock extends StatefulWidget {
  const SignUpMock({super.key});

  @override
  State<SignUpMock> createState() => _SignUpMockState();
}

class _SignUpMockState extends State<SignUpMock> {
  File? avatar;
  final picker = ImagePicker();
  TextEditingController dob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController residence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let's get your account setup",
                style: heading3Information,
              ),
              Space().height(context, 0.03),
              buildProfilePicture(
                context: context,
                onTap: () {},
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Name',
                context: context,
                controller: name,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {},
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Email',
                context: context,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Password',
                context: context,
                controller: password,
                isPassword: true,
                maxLines: 1,
                onChanged: (value) {},
              ),
              Space().height(context, 0.005),
              const Text(
                '8 or more characters\n1 or more capital letters\n1 or more special characters',
                style: heading6Neutral500,
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Phone Number',
                context: context,
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {},
              ),
              Space().height(context, 0.02),
              buildTappableTextField(
                hint: 'Residence',
                context: context,
                controller: residence,
                onTap: () {},
              ),
              Space().height(context, 0.02),
              buildTappableTextField(
                hint: 'Date of Birth',
                context: context,
                controller: dob,
                onTap: () {},
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                width: Sizes().width(context, 0.85),
                isActive: false,
                buttonName: 'Register',
                context: context,
                onPressed: () {},
              ),
              Space().height(context, 0.01),
              Container(
                height: Sizes().height(context, 0.1),
                color: rentWheelsNeutralLight0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: body2Neutral,
                    ),
                    Space().width(context, 0.01),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Login",
                        style: heading6InformationBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
