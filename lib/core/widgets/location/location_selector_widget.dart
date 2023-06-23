import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildLocationSelector({
  required String hint,
  required BuildContext context,
  required TextEditingController controller,
  required void Function() onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hint,
          style: heading5Information,
        ),
      ),
      Container(
        width: Sizes().width(context, 0.85),
        decoration: BoxDecoration(
          border: Border.all(
            color: rentWheelsNeutralLight200,
          ),
          borderRadius: BorderRadius.circular(
            Sizes().width(context, 0.035),
          ),
        ),
        padding: EdgeInsets.only(left: Sizes().width(context, 0.04)),
        child: GestureDetector(
          onTap: onTap,
          child: TextField(
            enabled: false,
            controller: controller,
            style: heading6Neutral900,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: heading6Neutral500,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    ],
  );
}
