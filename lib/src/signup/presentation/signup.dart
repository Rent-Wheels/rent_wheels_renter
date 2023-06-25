import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/src/search/custom_search_bar.dart';
import 'package:rent_wheels_renter/src/verify/presentation/verify_email.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/auth/auth_exceptions.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels_renter/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/profilePicture/profile_picture_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isAvatarValid = false;
  bool isDobValid = false;
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isResidenceValid = false;
  bool isPhoneNumberValid = false;

  File? avatar;
  final picker = ImagePicker();

  TextEditingController dob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController residence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool isActive() {
    return isAvatarValid &&
        isDobValid &&
        isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isResidenceValid &&
        isPhoneNumberValid;
  }

  openImage({required ImageSource source}) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        avatar = File(image.path);
        isAvatarValid = true;
      });
    }
  }

  bottomSheet() {
    return mediaBottomSheet(
      context: context,
      cameraOnTap: () {
        openImage(source: ImageSource.camera);
        Navigator.of(context).pop();
      },
      galleryOnTap: () {
        openImage(source: ImageSource.gallery);
        Navigator.of(context).pop();
      },
    );
  }

  presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime(2006),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dob.text = DateFormat.yMMMMd().format(pickedDate);
        isDobValid = true;
      });
    });
  }

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
                imageFile: avatar,
                onTap: bottomSheet,
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Full Name',
                context: context,
                controller: name,
                maxLines: 1,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  if (value.length >= 4) {
                    setState(() {
                      isNameValid = true;
                    });
                  } else {
                    setState(() {
                      isNameValid = false;
                    });
                  }
                },
              ),
              Space().height(context, 0.02),
              buildGenericTextfield(
                hint: 'Email',
                context: context,
                controller: email,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
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
                hint: 'Password',
                context: context,
                controller: password,
                isPassword: true,
                maxLines: 1,
                onChanged: (value) {
                  final regExp = RegExp(
                      r'(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*');
                  if (regExp.hasMatch(value)) {
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
                maxLines: 1,
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() {
                      isPhoneNumberValid = true;
                    });
                  } else {
                    setState(() {
                      isPhoneNumberValid = false;
                    });
                  }
                },
              ),
              Space().height(context, 0.02),
              buildTappableTextField(
                hint: 'Residence',
                context: context,
                controller: residence,
                onTap: () async {
                  final response = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomSearchScaffold(),
                    ),
                  );

                  if (response != null) {
                    setState(() {
                      residence.text = response;
                      isResidenceValid = true;
                    });
                  }
                },
              ),
              Space().height(context, 0.02),
              buildTappableTextField(
                hint: 'Date of Birth',
                context: context,
                controller: dob,
                onTap: presentDatePicker,
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                width: Sizes().width(context, 0.85),
                isActive: isActive(),
                buttonName: 'Register',
                context: context,
                onPressed: () async {
                  buildLoadingIndicator(context, 'Creating Account');
                  try {
                    UserCredential userCredential = await AuthService.firebase()
                        .createUserWithEmailAndPassword(
                      avatar: avatar!.path,
                      name: name.text,
                      phoneNumber: phoneNumber.text,
                      email: email.text,
                      password: password.text,
                      dob: DateFormat.yMMMMd().parse(dob.text),
                      residence: residence.text,
                    );

                    global.setGlobals(currentUser: userCredential.user!);

                    if (!mounted) return;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyEmail(),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    Navigator.pop(context);
                    if (e is WeakPasswordAuthException) {
                      showErrorPopUp(
                        'Please choose a stronger password',
                        context,
                      );
                    } else if (e is InvalidEmailException) {
                      showErrorPopUp(
                        'Email is already in use',
                        context,
                      );
                    } else {
                      showErrorPopUp(
                        e.toString(),
                        context,
                      );
                    }
                  }
                },
              ),
              Space().height(context, 0.01),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
