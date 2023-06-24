import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildAddMorePhotos({
  required BuildContext context,
  required void Function() onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Sizes().width(context, 0.85),
          height: Sizes().height(context, 0.05),
          decoration: BoxDecoration(
            border: Border.all(
              color: rentWheelsNeutralLight200,
            ),
            borderRadius: BorderRadius.circular(
              Sizes().width(context, 0.035),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.add,
              color: rentWheelsInformationDark900,
              size: Sizes().height(context, 0.02),
            ),
            Space().width(context, 0.005),
            const Text(
              'Add more photos.',
              style: body1Neutral500,
            )
          ],
        )
      ],
    ),
  );
}
