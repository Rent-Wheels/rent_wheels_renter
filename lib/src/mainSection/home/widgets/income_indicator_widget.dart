import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

Widget buildIncomeIndicator({
  required num? income,
  required String? label,
  required BuildContext context,
}) {
  return Container(
    width: Sizes().width(context, 0.47),
    height: Sizes().height(context, 0.15),
    padding: EdgeInsets.all(Sizes().height(context, 0.01)),
    decoration: BoxDecoration(
        color: rentWheelsBrandDark900,
        borderRadius: BorderRadius.circular(Sizes().height(context, 0.015))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label ?? 'null',
          style: heading4Neutral0,
        ),
        Space().height(context, 0.03),
        Text(
          'GH¢$income',
          style: heading3Neutral0,
        ),
      ],
    ),
  );
}
