import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildGenericTextfield({
  required String hint,
  TextInputType? keyboardType,
  TextInputAction? textInput,
  TextCapitalization? textCapitalization,
  int? minLines,
  int? maxLines,
  required BuildContext context,
  required TextEditingController controller,
  required void Function(String) onChanged,
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
        child: TextField(
          controller: controller,
          style: heading6Neutral900,
          keyboardType: keyboardType,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          textInputAction: textInput ?? TextInputAction.next,
          minLines: minLines,
          maxLines: maxLines,
          cursorColor: rentWheelsBrandDark900,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: heading6Neutral500,
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}
