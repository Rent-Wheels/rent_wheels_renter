import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildCarDetailsKeyValue({
  required String label,
  required String value,
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: body1Neutral900,
      ),
      SizedBox(
        width: Sizes().width(context, 0.4),
        child: Text(
          value,
          style: heading5Information,
        ),
      ),
    ],
  );
}
