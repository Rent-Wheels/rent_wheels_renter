import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_top_widget.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageOne extends StatefulWidget {
  final Car? car;
  final CarReviewType type;

  final TextEditingController make;
  final TextEditingController model;
  final TextEditingController color;
  final TextEditingController yearOfManufacture;
  final TextEditingController registrationNumber;

  final void Function(String) makeOnChanged;
  final void Function(String) yearOnChanged;
  final void Function(String) modelOnChanged;
  final void Function(String) colorOnChanged;
  final void Function(String) registrationOnChanged;

  const AddCarPageOne({
    super.key,
    this.car,
    required this.type,
    required this.make,
    required this.model,
    required this.color,
    required this.makeOnChanged,
    required this.yearOnChanged,
    required this.modelOnChanged,
    required this.colorOnChanged,
    required this.yearOfManufacture,
    required this.registrationNumber,
    required this.registrationOnChanged,
  });

  @override
  State<AddCarPageOne> createState() => _AddCarPageOneState();
}

class _AddCarPageOneState extends State<AddCarPageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
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
                  buildAddCarTop(
                    context: context,
                    page: 1,
                    title: widget.type == CarReviewType.add
                        ? 'Add Car'
                        : 'Update Car',
                  ),
                  Space().height(context, 0.03),
                  buildGenericTextfield(
                      context: context,
                      hint: 'Car Make',
                      controller: widget.make,
                      onChanged: widget.makeOnChanged),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Model',
                    controller: widget.model,
                    onChanged: widget.modelOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Color',
                    controller: widget.color,
                    onChanged: widget.colorOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Year of Manufacture',
                    controller: widget.yearOfManufacture,
                    keyboardType: TextInputType.number,
                    onChanged: widget.yearOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Registration Number',
                    controller: widget.registrationNumber,
                    textCapitalization: TextCapitalization.characters,
                    textInput: TextInputAction.done,
                    onChanged: widget.registrationOnChanged,
                  ),
                ],
              ),
              Space().height(context, 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
