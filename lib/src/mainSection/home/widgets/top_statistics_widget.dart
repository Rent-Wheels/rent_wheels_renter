import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/home/widgets/line_chart_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/home/widgets/most_profitable_car_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

Widget buildTopStatistics({
  num? price,
  num? noOfReservations,
  required Car car,
  required List data,
  required String label,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: Sizes().width(context, 0.01),
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
        Expanded(child: buildLineChart(data: data, context: context)),
      ],
    ),
  );
}
