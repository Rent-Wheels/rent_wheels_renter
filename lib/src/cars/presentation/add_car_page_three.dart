import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/search/custom_search_bar.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car_page_four.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';

class AddCarPageThree extends StatefulWidget {
  final Car carDetails;
  const AddCarPageThree({super.key, required this.carDetails});

  @override
  State<AddCarPageThree> createState() => _AddCarPageThreeState();
}

class _AddCarPageThreeState extends State<AddCarPageThree> {
  late bool isTermsValid;
  late bool isLocationValid;
  late bool isDescriptionValid;

  TextEditingController terms = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();

  Car carDetails = Car();

  bool isActive() {
    return isTermsValid && isLocationValid && isDescriptionValid;
  }

  @override
  void initState() {
    terms.text = widget.carDetails.terms ?? "";
    location.text = widget.carDetails.location ?? "";
    description.text = widget.carDetails.description ?? "";

    isTermsValid = widget.carDetails.terms == null ? false : true;
    isLocationValid = widget.carDetails.location == null ? false : true;
    isDescriptionValid = widget.carDetails.description == null ? false : true;

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
                  buildAddCarTop(context: context, page: 3),
                  Space().height(context, 0.03),
                  buildTappableTextField(
                    hint: 'Car Location',
                    context: context,
                    controller: location,
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomSearchScaffold(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          location.text = result;
                          isLocationValid = true;
                          carDetails.location = result;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    context: context,
                    hint: 'Car Description',
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    textInput: TextInputAction.newline,
                    minLines: 4,
                    maxLines: null,
                    onChanged: (value) {
                      final noSpaces = value.replaceAll(" ", "");
                      if (noSpaces.isNotEmpty && noSpaces.length > 10) {
                        setState(() {
                          isDescriptionValid = true;
                          carDetails.description = value;
                        });
                      } else {
                        setState(() {
                          isDescriptionValid = false;
                        });
                      }
                    },
                  ),
                  Space().height(context, 0.02),
                  buildGenericTextfield(
                    hint: 'Rental T&C',
                    context: context,
                    controller: terms,
                    keyboardType: TextInputType.multiline,
                    textInput: TextInputAction.newline,
                    minLines: 4,
                    maxLines: null,
                    onChanged: (value) {
                      final noSpaces = value.replaceAll(" ", "");
                      if (noSpaces.isNotEmpty && noSpaces.length > 10) {
                        setState(() {
                          isTermsValid = true;
                          carDetails.terms = value;
                        });
                      } else {
                        setState(() {
                          isTermsValid = false;
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
                    MaterialPageRoute(
                      builder: (context) => AddCarPageFour(
                        carDetails: carDetails,
                      ),
                    ),
                  );
                  if (car != null) {
                    carDetails = car;
                    setState(() {
                      terms.text = carDetails.terms!;
                      location.text = carDetails.location!;
                      description.text = carDetails.description!;
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
