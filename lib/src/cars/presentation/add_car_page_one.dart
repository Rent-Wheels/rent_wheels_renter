import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/dropdown_input_field.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarMock extends StatefulWidget {
  const AddCarMock({super.key});

  @override
  State<AddCarMock> createState() => _AddCarMockState();
}

class _AddCarMockState extends State<AddCarMock> {
  bool isMakeValid = false;
  bool isYearValid = false;
  bool isTypeValid = false;
  bool isModelValid = false;
  bool isColorValid = false;
  bool isRegistrationValid = false;

  TextEditingController make = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController yearOfManufacture = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();

  bool isActive() {
    return isMakeValid &&
        isModelValid &&
        isColorValid &&
        isTypeValid &&
        isYearValid &&
        isRegistrationValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add car',
                    style: heading2Information,
                  ),
                  Space().height(context, 0.01),
                  const Text(
                    'STEP 1 OF 4',
                    style: heading6Neutral500,
                  ),
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
                      if (noSpaceValue.length >= 2) {
                        setState(() {
                          isModelValid = true;
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
                        });
                      } else {
                        setState(() {
                          isColorValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildDropDownInputField(
                    context: context,
                    hintText: 'Car Type',
                    items: [
                      const DropdownMenuItem(
                        value: 'Bus',
                        child: Text('Bus'),
                      ),
                      const DropdownMenuItem(
                        value: 'SUV',
                        child: Text('SUV'),
                      ),
                      const DropdownMenuItem(
                        value: 'Van',
                        child: Text('Van'),
                      ),
                      const DropdownMenuItem(
                        value: 'Sedan',
                        child: Text('Sedan'),
                      ),
                      const DropdownMenuItem(
                        value: 'Pickup',
                        child: Text('Pickup'),
                      ),
                      const DropdownMenuItem(
                        value: 'Minivan',
                        child: Text('Minivan'),
                      ),
                      const DropdownMenuItem(
                        value: 'Offroad',
                        child: Text('Offroad'),
                      ),
                      const DropdownMenuItem(
                        value: 'Hatchback',
                        child: Text('Hatchback'),
                      ),
                      const DropdownMenuItem(
                        value: 'Crossover',
                        child: Text('Crossover'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          type.text = value;
                          isTypeValid = true;
                        });
                      } else {
                        setState(() {
                          isTypeValid = false;
                        });
                      }
                    },
                    prefixIcon: null,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Year of Manufacture',
                    controller: yearOfManufacture,
                    onChanged: (value) {
                      if (value.length == 4 && isNumeric(value)) {
                        setState(() {
                          isYearValid = true;
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
                    onChanged: (value) {
                      final noSpaceValue = value.replaceAll(" ", "");
                      if (noSpaceValue.length >= 3 && isAscii(noSpaceValue)) {
                        setState(() {
                          isRegistrationValid = true;
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
              Space().height(context, 0.06),
              buildGenericButtonWidget(
                context: context,
                width: Sizes().width(context, 0.8),
                isActive: isActive(),
                buttonName: "Continue",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
