import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';

import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

GestureDetector buildGenericButtonWidget({
  required double width,
  required bool isActive,
  required String buttonName,
  required BuildContext context,
  required void Function() onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width,
      height: Sizes().height(context, 0.06),
      decoration: BoxDecoration(
        color: isActive ? rentWheelsBrandDark900 : rentWheelsBrandDark900Trans,
        borderRadius: BorderRadius.circular(Sizes().width(context, 0.035)),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: heading5Neutral0,
        ),
      ),
    ),
  );
}
