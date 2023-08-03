import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/car_image_widget.dart';

import 'package:rent_wheels_renter/core/util/date_formatter.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

Widget buildReservationSections({
  required Car car,
  required bool isLoading,
  required BuildContext context,
  required Reservation reservation,
  required void Function()? onPressed,
  required void Function()? onAccept,
  required void Function()? onDecline,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCarImage(
              imageUrl: car.media![0].mediaURL!,
              reservationStatus: reservation.status ?? '',
              context: context,
            ),
            Space().height(context, 0.01),
            isLoading
                ? Container(
                    width: double.infinity,
                    height: Sizes().height(context, 0.02),
                    decoration: BoxDecoration(
                      color: rentWheelsNeutralLight0,
                      borderRadius:
                          BorderRadius.circular(Sizes().height(context, 0.2)),
                    ),
                  )
                : Text(
                    '${car.yearOfManufacture} ${car.make} ${car.model}',
                    style: heading3Information,
                  ),
            Space().height(context, 0.01),
            isLoading
                ? Container(
                    width: double.infinity,
                    height: Sizes().height(context, 0.02),
                    decoration: BoxDecoration(
                      color: rentWheelsNeutralLight0,
                      borderRadius:
                          BorderRadius.circular(Sizes().height(context, 0.2)),
                    ),
                  )
                : Text(
                    '${reservation.destination}, ${formatDate(reservation.startDate!)} - ${formatDate(reservation.returnDate!)}',
                    style: heading6Brand,
                  ),
          ],
        ),
      ),
      Space().height(context, 0.02),
      if (reservation.status?.toLowerCase() == 'pending')
        Row(
          children: [
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.4),
              isActive: true,
              btnColor: rentWheelsSuccessDark700,
              buttonName: '✓ Accept',
              context: context,
              onPressed: onAccept,
            ),
            Space().width(context, 0.04),
            buildGenericButtonWidget(
              isActive: true,
              context: context,
              buttonName: 'x Decline',
              btnColor: rentWheelsErrorDark700,
              width: Sizes().width(context, 0.4),
              onPressed: onDecline,
            ),
          ],
        )
    ],
  );
}
