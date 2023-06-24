import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/src/cars/presentation/all_cars.dart';

class AddCarSuccessMock extends StatelessWidget {
  final Car carDetails;
  const AddCarSuccessMock({super.key, required this.carDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_sharp,
              color: rentWheelsSuccessDark800,
              size: Sizes().height(context, 0.15),
            ),
            Space().height(context, 0.02),
            RichText(
              text: TextSpan(
                text:
                    "${carDetails.yearOfManufacture} ${carDetails.make} ${carDetails.model} ",
                style: heading5Information,
                children: const [
                  TextSpan(
                    text: "has been added successfully.",
                    style: body1Information,
                  )
                ],
              ),
            ),
            Space().height(context, 0.05),
            buildGenericButtonWidget(
              context: context,
              width: Sizes().width(context, 0.85),
              isActive: true,
              buttonName: "View All Cars",
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllCars(),
                ),
                (route) => false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
