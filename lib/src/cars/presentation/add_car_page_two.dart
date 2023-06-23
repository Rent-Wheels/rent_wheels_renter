import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/dropdown_input_field.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car_page_three.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/widgets/rate_input_field_widget.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageTwo extends StatefulWidget {
  const AddCarPageTwo({super.key});

  @override
  State<AddCarPageTwo> createState() => _AddCarPageTwoState();
}

class _AddCarPageTwoState extends State<AddCarPageTwo> {
  bool isRateValid = false;
  bool isPlanValid = true;
  bool isTypeValid = false;
  bool isColorValid = false;
  bool isDurationValid = true;
  bool isCapacityValid = false;
  bool isConditionValid = false;
  bool isMaxDurationValid = false;
  bool isRegistrationValid = false;

  TextEditingController type = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController plan = TextEditingController(text: '/hr');
  TextEditingController duration = TextEditingController(text: 'days');

  bool isActive() {
    return isRateValid &&
        isTypeValid &&
        isPlanValid &&
        isDurationValid &&
        isCapacityValid &&
        isMaxDurationValid &&
        isConditionValid;
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
                  buildAddCarTop(context: context, page: 2),
                  Space().height(context, 0.03),
                  buildDropDownInputField(
                    context: context,
                    hintText: 'Car Type',
                    items: const [
                      DropdownMenuItem(
                        value: 'Bus',
                        child: Text('Bus'),
                      ),
                      DropdownMenuItem(
                        value: 'SUV',
                        child: Text('SUV'),
                      ),
                      DropdownMenuItem(
                        value: 'Van',
                        child: Text('Van'),
                      ),
                      DropdownMenuItem(
                        value: 'Sedan',
                        child: Text('Sedan'),
                      ),
                      DropdownMenuItem(
                        value: 'Pickup',
                        child: Text('Pickup'),
                      ),
                      DropdownMenuItem(
                        value: 'Minivan',
                        child: Text('Minivan'),
                      ),
                      DropdownMenuItem(
                        value: 'Offroad',
                        child: Text('Offroad'),
                      ),
                      DropdownMenuItem(
                        value: 'Hatchback',
                        child: Text('Hatchback'),
                      ),
                      DropdownMenuItem(
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
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'No. of Seats',
                    controller: capacity,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          value.length <= 2 &&
                          int.parse(value) != 0 &&
                          isNumeric(value)) {
                        setState(() {
                          isCapacityValid = true;
                        });
                      } else {
                        setState(() {
                          isCapacityValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildDropDownInputField(
                    context: context,
                    hintText: 'Car Condition',
                    items: const [
                      DropdownMenuItem(
                        value: 'Excellent',
                        child: Text('Excellent'),
                      ),
                      DropdownMenuItem(
                        value: 'Good',
                        child: Text('Good'),
                      ),
                      DropdownMenuItem(
                        value: 'Fair',
                        child: Text('Fair'),
                      ),
                      DropdownMenuItem(
                        value: 'Poor',
                        child: Text('Poor'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          condition.text = value;
                          isConditionValid = true;
                        });
                      } else {
                        setState(() {
                          isConditionValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildRateInputField(
                    textFlex: 4,
                    dropFlex: 1,
                    items: const [
                      DropdownMenuItem(
                        value: '/hr',
                        child: Text('/hr'),
                      ),
                      DropdownMenuItem(
                        value: '/day',
                        child: Text('/day'),
                      ),
                    ],
                    value: plan.text,
                    hintText: 'Rental Rate',
                    context: context,
                    controller: rate,
                    planChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          plan.text = value;
                          isPlanValid = true;
                        });
                      } else {
                        setState(() {
                          isPlanValid = false;
                        });
                      }
                    },
                    rateChanged: (value) {
                      if (isNumeric(value)) {
                        setState(() {
                          isRateValid = true;
                        });
                      } else {
                        setState(() {
                          isRateValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildRateInputField(
                    textFlex: 6,
                    dropFlex: 2,
                    items: const [
                      DropdownMenuItem(
                        value: 'days',
                        child: Text('days'),
                      ),
                      DropdownMenuItem(
                        value: 'weeks',
                        child: Text('weeks'),
                      ),
                      DropdownMenuItem(
                        value: 'months',
                        child: Text('months'),
                      ),
                    ],
                    value: duration.text,
                    hintText: 'Maximum Duration of Rental',
                    context: context,
                    controller: maxDuration,
                    planChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          duration.text = value;
                          isDurationValid = true;
                        });
                      } else {
                        setState(() {
                          isDurationValid = false;
                        });
                      }
                    },
                    rateChanged: (value) {
                      if (isNumeric(value)) {
                        setState(() {
                          isMaxDurationValid = true;
                        });
                      } else {
                        setState(() {
                          isMaxDurationValid = false;
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCarPageThree(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
