import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildReservationStatus({
  required String status,
  required BuildContext context,
}) {
  return Container(
    alignment: Alignment.center,
    width: Sizes().width(context, 0.23),
    padding: EdgeInsets.all(Sizes().height(context, 0.008)),
    decoration: BoxDecoration(
      color: status == 'Completed'
          ? rentWheelsSuccessDark800
          : status == 'Cancelled' || status == 'Declined'
              ? rentWheelsErrorDark700
              : status == 'Pending'
                  ? rentWheelsWarningDark700
                  : status == 'Accepted' || status == 'Paid'
                      ? rentWheelsSuccess
                      : status == 'Ongoing'
                          ? rentWheelsSuccessDark600
                          : rentWheelsNeutralLight0,
      borderRadius: BorderRadius.circular(Sizes().height(context, 0.02)),
    ),
    child: Text(
      status,
      style: heading6Neutral0,
    ),
  );
}
