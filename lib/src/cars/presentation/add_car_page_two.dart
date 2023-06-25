import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car_page_three.dart';
import 'package:rent_wheels_renter/src/cars/widgets/rate_input_field_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/dropdown_input_field.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageTwo extends StatefulWidget {
  final Car carDetails;
  const AddCarPageTwo({super.key, required this.carDetails});

  @override
  State<AddCarPageTwo> createState() => _AddCarPageTwoState();
}

class _AddCarPageTwoState extends State<AddCarPageTwo> {
  late bool isRateValid;
  late bool isPlanValid;
  late bool isTypeValid;
  late bool isDurationValid;
  late bool isCapacityValid;
  late bool isConditionValid;
  late bool isMaxDurationValid;

  TextEditingController plan = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController duration = TextEditingController();

  Car carDetails = Car();

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
  void initState() {
    type.text = widget.carDetails.type ?? "";
    plan.text = widget.carDetails.plan ?? "/hr";
    condition.text = widget.carDetails.condition ?? "";
    rate.text =
        widget.carDetails.rate == null ? "" : widget.carDetails.rate.toString();
    capacity.text = widget.carDetails.capacity == null
        ? ""
        : widget.carDetails.capacity.toString();
    duration.text = widget.carDetails.duration ?? "days";
    maxDuration.text = widget.carDetails.maxDuration == null
        ? ""
        : widget.carDetails.maxDuration.toString();

    isPlanValid = true;
    isDurationValid = true;
    isTypeValid = widget.carDetails.type == null ? false : true;
    isRateValid = widget.carDetails.rate == null ? false : true;
    isCapacityValid = widget.carDetails.capacity == null ? false : true;
    isConditionValid = widget.carDetails.condition == null ? false : true;
    isMaxDurationValid = widget.carDetails.maxDuration == null ? false : true;

    carDetails = widget.carDetails;

    super.initState();
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
          onPressed: () {
            Navigator.pop(context, carDetails);
          },
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
                    value: type.text.isNotEmpty ? type.text : null,
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
                          carDetails.type = value;
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
                          carDetails.capacity = num.parse(value);
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
                    value: condition.text.isNotEmpty ? condition.text : null,
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
                          carDetails.condition = value;
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
                    prefixText: 'GH¢',
                    hintText: 'Rental Rate',
                    context: context,
                    controller: rate,
                    planChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          plan.text = value;
                          isPlanValid = true;
                          carDetails.plan = value;
                        });
                      } else {
                        setState(() {
                          isPlanValid = false;
                        });
                      }
                    },
                    rateChanged: (value) {
                      if (isNumeric(value) && num.parse(value) > 0) {
                        setState(() {
                          isRateValid = true;
                          carDetails.rate = num.parse(value);
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
                          carDetails.duration = value;
                        });
                      } else {
                        setState(() {
                          isDurationValid = false;
                        });
                      }
                    },
                    rateChanged: (value) {
                      if (isNumeric(value) && num.parse(value) > 0) {
                        setState(() {
                          isMaxDurationValid = true;
                          carDetails.maxDuration = num.parse(value);
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
                onPressed: () async {
                  carDetails.plan = plan.text;
                  carDetails.duration = duration.text;

                  final car = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCarPageThree(
                        carDetails: carDetails,
                      ),
                    ),
                  );

                  if (car != null) {
                    carDetails = car;
                    setState(() {
                      type.text = carDetails.type!;
                      plan.text = carDetails.plan!;
                      condition.text = carDetails.condition!;
                      carDetails.duration = duration.text;
                      rate.text = carDetails.rate.toString();
                      capacity.text = carDetails.capacity.toString();
                      maxDuration.text = carDetails.maxDuration.toString();
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
