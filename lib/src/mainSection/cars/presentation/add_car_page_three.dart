import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_top_widget.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageThree extends StatefulWidget {
  final CarReviewType type;

  final TextEditingController terms;
  final TextEditingController location;
  final TextEditingController description;

  final void Function() locationOnTap;
  final void Function(String) tcOnChanged;
  final void Function(String) descriptionOnChanged;

  const AddCarPageThree({
    super.key,
    required this.type,
    required this.terms,
    required this.location,
    required this.description,
    required this.tcOnChanged,
    required this.locationOnTap,
    required this.descriptionOnChanged,
  });

  @override
  State<AddCarPageThree> createState() => _AddCarPageThreeState();
}

class _AddCarPageThreeState extends State<AddCarPageThree> {
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
                    page: 3,
                    title: widget.type == CarReviewType.add
                        ? 'Add Car'
                        : 'Update Car',
                  ),
                  Space().height(context, 0.03),
                  buildTappableTextField(
                    hint: 'Car Location',
                    context: context,
                    controller: widget.location,
                    onTap: widget.locationOnTap,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Description',
                    controller: widget.description,
                    keyboardType: TextInputType.multiline,
                    textInput: TextInputAction.newline,
                    minLines: 4,
                    maxLines: null,
                    onChanged: widget.descriptionOnChanged,
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    hint: 'Rental T&C',
                    context: context,
                    controller: widget.terms,
                    keyboardType: TextInputType.multiline,
                    textInput: TextInputAction.newline,
                    minLines: 4,
                    maxLines: null,
                    onChanged: widget.tcOnChanged,
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
