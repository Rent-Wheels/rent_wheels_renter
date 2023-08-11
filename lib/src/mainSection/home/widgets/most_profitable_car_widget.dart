import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildMostProfitableCar({
  num? price,
  num? noOfReservations,
  required Car car,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: Sizes().height(context, 0.02)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Sizes().width(context, 0.2),
              height: Sizes().height(context, 0.07),
              margin: EdgeInsets.only(right: Sizes().width(context, 0.02)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(car.media![0].mediaURL!),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.005),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Sizes().width(context, 0.5),
                  child: Text(
                    '${car.yearOfManufacture} ${car.make} ${car.model}',
                    style: heading5Information,
                  ),
                ),
                Space().height(context, 0.005),
                Text(
                  car.registrationNumber!,
                  style: body2Neutral,
                ),
              ],
            ),
          ],
        ),
        if (price != null)
          Text(
            'GH¢$price',
            style: body1Neutral900,
          ),
        if (noOfReservations != null)
          Text(
            '$noOfReservations',
            style: body1Neutral900,
          ),
      ],
    ),
  );
}
