import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/src/search/custom_search_bar.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/location/location_selector_widget.dart';
import 'package:rent_wheels_renter/core/widgets/textfields/generic_textfield_widget.dart';

class AddCarPageThree extends StatefulWidget {
  const AddCarPageThree({super.key});

  @override
  State<AddCarPageThree> createState() => _AddCarPageThreeState();
}

class _AddCarPageThreeState extends State<AddCarPageThree> {
  bool isTermsValid = false;
  bool isLocationValid = false;
  bool isDescriptionValid = false;

  TextEditingController terms = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();

  bool isActive() {
    return isTermsValid && isLocationValid && isDescriptionValid;
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
                  buildAddCarTop(context: context, page: 3),
                  Space().height(context, 0.03),
                  buildLocationSelector(
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
                    minLines: 4,
                    maxLines: null,
                    onChanged: (value) {
                      final noSpaces = value.replaceAll(" ", "");
                      if (noSpaces.isNotEmpty && noSpaces.length > 10) {
                        setState(() {
                          isDescriptionValid = true;
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
                    minLines: 4,
                    maxLines: null,
                    onChanged: (value) {
                      final noSpaces = value.replaceAll(" ", "");
                      if (noSpaces.isNotEmpty && noSpaces.length > 10) {
                        setState(() {
                          isTermsValid = true;
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
