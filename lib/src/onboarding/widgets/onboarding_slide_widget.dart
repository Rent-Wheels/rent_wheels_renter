import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildOnboadingSlide({
  required String heading,
  required String imagePath,
  required String description,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.only(right: Sizes().width(context, 0.03)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Sizes().height(context, 0.4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imagePath,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.015),
            ),
          ),
        ),
        Space().height(context, 0.08),
        Text(
          heading,
          style: heading3Brand,
        ),
        Space().height(context, 0.02),
        Text(
          description,
          style: body1Neutral500,
        ),
      ],
    ),
  );
}
