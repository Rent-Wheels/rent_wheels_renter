import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/src/mainSection/home/widgets/most_profitable_car_widget.dart';

buildTopStatistics({
  num? price,
  num? noOfReservations,
  required Car car,
  required String label,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.only(
      right: Sizes().width(context, 0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: heading4Brand,
        ),
        Space().height(context, 0.02),
        buildMostProfitableCar(
          car: car,
          price: price,
          context: context,
          noOfReservations: noOfReservations,
        ),
      ],
    ),
  );
}
