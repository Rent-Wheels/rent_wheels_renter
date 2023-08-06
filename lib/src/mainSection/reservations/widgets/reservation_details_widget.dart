import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/price_details_widget.dart';

import 'package:rent_wheels_renter/core/util/date_formatter.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';

buildReservationDetails({
  required Car car,
  required String pageTitle,
  required Duration duration,
  required BackendUser customer,
  required BuildContext context,
  required Reservation reservation,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        pageTitle,
        style: heading3Information,
      ),
      Space().height(context, 0.03),
      Flexible(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Vehicle Details",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.yearOfManufacture} ${car.make} ${car.model}',
                      style: heading5Neutral,
                    ),
                    Space().height(context, 0.008),
                    Text(
                      'GH¢ ${car.rate} ${car.plan}',
                      style: heading5Information,
                    ),
                    Space().height(context, 0.008),
                    SizedBox(
                      width: Sizes().width(context, 0.6),
                      child: Text(
                        '${car.location}',
                        style: body2Neutral900,
                      ),
                    ),
                    Space().height(context, 0.008),
                    SizedBox(
                      width: Sizes().width(context, 0.6),
                      child: Text(
                        '${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                        style: heading6Neutral900Bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: Sizes().height(context, 0.15),
                  width: Sizes().width(context, 0.3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        car.media![0].mediaURL!,
                      ),
                    ),
                    border: Border.all(color: rentWheelsNeutralLight200),
                    color: rentWheelsNeutralLight0,
                    borderRadius: BorderRadius.circular(
                      Sizes().height(context, 0.015),
                    ),
                  ),
                ),
              ],
            ),
            Space().height(context, 0.04),
            const Text(
              "Customer Information",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            buildDetailsKeyValue(
              label: 'Full Name',
              value: customer.name!,
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Address Line',
              value: customer.placeOfResidence!,
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Phone Number',
              value: customer.phoneNumber!,
              context: context,
            ),
            Space().height(context, 0.01),
            buildDetailsKeyValue(
              label: 'Email Address',
              value: customer.email!,
              context: context,
            ),
          ],
        ),
      ),
      Space().height(context, 0.06),
      Flexible(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price",
              style: heading5Neutral,
            ),
            Space().height(context, 0.02),
            buildPriceDetailsKeyValue(
              label: 'Trip Price',
              value: 'GH¢ ${car.rate} ${car.plan}',
              context: context,
            ),
            Space().height(context, 0.01),
            buildPriceDetailsKeyValue(
              label: 'Destination',
              value: reservation.destination!,
              context: context,
            ),
            Space().height(context, 0.01),
            buildPriceDetailsKeyValue(
              label: 'Duration',
              value: duration.inDays == 1
                  ? '${duration.inDays} day'
                  : '${duration.inDays} days',
              context: context,
            ),
            Space().height(context, 0.01),
            DottedDashedLine(
              height: 0,
              axis: Axis.horizontal,
              width: Sizes().width(context, 1),
              dashColor: rentWheelsNeutral,
            ),
            Space().height(context, 0.01),
            SizedBox(
              width: Sizes().width(context, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Total',
                    style: heading5Neutral,
                  ),
                  Text(
                    'GH¢ ${reservation.price}',
                    style: heading5Neutral,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
