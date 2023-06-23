import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildDropDownInputField({
  required BuildContext context,
  dynamic value,
  required items,
  required onChanged,
  required Icon? prefixIcon,
  String? hintText,
  Color? borderColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hintText!,
          style: heading5Information,
        ),
      ),
      Container(
        width: Sizes().width(context, 0.85),
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.02),
          bottom: Sizes().height(context, 0.004),
          top: Sizes().height(context, 0.004),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: rentWheelsNeutralLight200,
          ),
          borderRadius: BorderRadius.circular(
            Sizes().width(context, 0.035),
          ),
        ),
        child: DropdownButtonFormField(
          value: value,
          icon: Icon(
            Icons.arrow_drop_down,
            color: rentWheelsNeutral,
            size: Sizes().height(context, 0.03),
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: heading6Neutral500,
          ),
          style: heading6Neutral900,
          dropdownColor: rentWheelsNeutralLight0,
          items: items,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
