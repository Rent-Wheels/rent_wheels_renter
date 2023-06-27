import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car_page_two.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageOne extends StatefulWidget {
  const AddCarPageOne({super.key});

  @override
  State<AddCarPageOne> createState() => _AddCarPageOneState();
}

class _AddCarPageOneState extends State<AddCarPageOne> {
  bool isMakeValid = false;
  bool isYearValid = false;
  bool isModelValid = false;
  bool isColorValid = false;
  bool isRegistrationValid = false;

  TextEditingController make = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController yearOfManufacture = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();

  bool isActive() {
    return isMakeValid &&
        isModelValid &&
        isColorValid &&
        isYearValid &&
        isRegistrationValid;
  }

  Car carDetails = Car();

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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAddCarTop(context: context, page: 1),
                  Space().height(context, 0.03),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Make',
                    controller: make,
                    onChanged: (value) {
                      final noSpaceValue = value.replaceAll(" ", "");
                      if (noSpaceValue.length >= 3 && isAlpha(noSpaceValue)) {
                        setState(() {
                          isMakeValid = true;
                          carDetails.make = value;
                        });
                      } else {
                        setState(() {
                          isMakeValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Model',
                    controller: model,
                    onChanged: (value) {
                      final noSpaceValue = value.replaceAll(" ", "");
                      if (noSpaceValue.length >= 2 &&
                          isAlphanumeric(noSpaceValue)) {
                        setState(() {
                          isModelValid = true;
                          carDetails.model = value;
                        });
                      } else {
                        setState(() {
                          isModelValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Color',
                    controller: color,
                    onChanged: (value) {
                      final noSpaceValue = value.replaceAll(" ", "");
                      if (noSpaceValue.length >= 3 && isAlpha(noSpaceValue)) {
                        setState(() {
                          isColorValid = true;
                          carDetails.color = value;
                        });
                      } else {
                        setState(() {
                          isColorValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Year of Manufacture',
                    controller: yearOfManufacture,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (num.parse(value) >= 1970 &&
                          num.parse(value) <= 2023) {
                        setState(() {
                          isYearValid = true;
                          carDetails.yearOfManufacture = value;
                        });
                      } else {
                        setState(() {
                          isYearValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Registration Number',
                    controller: registrationNumber,
                    textCapitalization: TextCapitalization.characters,
                    textInput: TextInputAction.done,
                    onChanged: (value) {
                      final registrationRegexp = RegExp(
                          r'^[A-Z]{2}\s\d{1,4}(\s[A-Z]{1}|-[0][9]|-[1][0-9]|-[2][0-3])$');
                      if (registrationRegexp.hasMatch(value)) {
                        setState(() {
                          isRegistrationValid = true;
                          carDetails.registrationNumber = value;
                        });
                      } else {
                        setState(() {
                          isRegistrationValid = false;
                        });
                      }
                    },
                  ),
                ],
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                context: context,
                width: Sizes().width(context, 0.8),
                isActive: isActive(),
                buttonName: "Continue",
                onPressed: () async {
                  final car = await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddCarPageTwo(
                        carDetails: carDetails,
                      ),
                    ),
                  );

                  if (car != null) {
                    carDetails = car;

                    setState(() {
                      make.text = carDetails.make!;
                      model.text = carDetails.model!;
                      color.text = carDetails.color!;
                      yearOfManufacture.text = carDetails.yearOfManufacture!;
                      registrationNumber.text = carDetails.registrationNumber!;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
