import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/reservations/reservation_status_widget.dart';

buildCarImage({
  required String imageUrl,
  required BuildContext context,
  required String reservationStatus,
}) {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      Container(
        height: Sizes().height(context, 0.2),
        width: Sizes().width(context, 0.92),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes().height(context, 0.02)),
          color: rentWheelsNeutralLight0,
          image: imageUrl == ''
              ? null
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl),
                ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(
          left: Sizes().width(context, 0.02),
          top: Sizes().height(context, 0.01),
        ),
        child: buildReservationStatus(
          status: reservationStatus,
          context: context,
        ),
      )
    ],
  );
}
