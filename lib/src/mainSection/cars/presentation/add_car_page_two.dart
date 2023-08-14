import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/rate_input_field_widget.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/dropdown_input_field.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageTwo extends StatefulWidget {
  final CarReviewType type;

  final TextEditingController plan;
  final TextEditingController rate;
  final TextEditingController carType;
  final TextEditingController capacity;
  final TextEditingController duration;
  final TextEditingController condition;
  final TextEditingController maxDuration;

  final void Function(String) seatOnChanged;
  final void Function(String) rentalRateOnChanged;
  final void Function(String) maxDurationOnChanged;

  final void Function(Object?)? carTypeOnChanged;
  final void Function(Object?)? rentalPlanOnChanged;
  final void Function(Object?)? carConditionOnChanged;
  final void Function(Object?)? rentalDurationOnChanged;

  const AddCarPageTwo({
    super.key,
    required this.type,
    required this.plan,
    required this.rate,
    required this.carType,
    required this.capacity,
    required this.duration,
    required this.condition,
    required this.maxDuration,
    required this.seatOnChanged,
    required this.carTypeOnChanged,
    required this.rentalPlanOnChanged,
    required this.rentalRateOnChanged,
    required this.maxDurationOnChanged,
    required this.carConditionOnChanged,
    required this.rentalDurationOnChanged,
  });

  @override
  State<AddCarPageTwo> createState() => _AddCarPageTwoState();
}

class _AddCarPageTwoState extends State<AddCarPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAddCarTop(
                    context: context,
                    page: 2,
                    title: widget.type == CarReviewType.add
                        ? 'Add Car'
                        : 'Update Car',
                  ),
                  Space().height(context, 0.03),
                  buildDropDownInputField(
                    context: context,
                    value: widget.carType.text.isNotEmpty
                        ? widget.carType.text
                        : null,
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
                    onChanged: widget.carTypeOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'No. of Seats',
                    controller: widget.capacity,
                    keyboardType: TextInputType.number,
                    onChanged: widget.seatOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildDropDownInputField(
                      context: context,
                      value: widget.condition.text.isNotEmpty
                          ? widget.condition.text
                          : null,
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
                      onChanged: widget.carConditionOnChanged),
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
                    value: widget.plan.text,
                    prefixText: 'GH¢',
                    hintText: 'Rental Rate',
                    context: context,
                    controller: widget.rate,
                    planChanged: widget.rentalPlanOnChanged,
                    rateChanged: widget.rentalRateOnChanged,
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
                    value: widget.duration.text,
                    hintText: 'Maximum Duration of Rental',
                    context: context,
                    controller: widget.maxDuration,
                    planChanged: widget.rentalDurationOnChanged,
                    rateChanged: widget.maxDurationOnChanged,
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
