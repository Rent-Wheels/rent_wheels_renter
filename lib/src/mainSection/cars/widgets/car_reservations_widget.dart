import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';
import 'package:rent_wheels_renter/core/widgets/reservations/reservation_status_widget.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildCarReservations({
  required String status,
  required BackendUser customer,
  required BuildContext context,
  required void Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: Sizes().height(context, 0.06),
      padding: EdgeInsets.symmetric(vertical: Sizes().height(context, 0.01)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            customer.name!,
            style: body1Neutral900,
          ),
          buildReservationStatus(status: status, context: context),
        ],
      ),
    ),
  );
}
