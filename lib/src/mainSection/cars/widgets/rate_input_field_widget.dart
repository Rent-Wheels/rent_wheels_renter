import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';

buildRateInputField({
  dynamic value,
  String? prefixText,
  required items,
  required planChanged,
  required int textFlex,
  required int dropFlex,
  required String hintText,
  required BuildContext context,
  required TextEditingController controller,
  required void Function(String) rateChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
        child: Text(
          hintText,
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
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.02),
        ),
        child: Row(
          children: [
            Flexible(
              flex: textFlex,
              child: TextField(
                controller: controller,
                style: heading6Neutral900,
                decoration: InputDecoration(
                  prefix: prefixText != null
                      ? Padding(
                          padding: EdgeInsets.only(
                            right: Sizes().width(context, 0.005),
                          ),
                          child: Text(
                            prefixText,
                            style: heading6Neutral900,
                          ),
                        )
                      : null,
                  hintText: hintText,
                  hintStyle: heading6Neutral500,
                  border: InputBorder.none,
                ),
                onChanged: rateChanged,
                keyboardType: TextInputType.number,
              ),
            ),
            Flexible(
              flex: dropFlex,
              child: DropdownButtonFormField(
                alignment: Alignment.centerRight,
                value: value,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: rentWheelsNeutral,
                  size: Sizes().height(context, 0.03),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: heading6Neutral500,
                ),
                style: heading6Neutral900,
                dropdownColor: rentWheelsNeutralLight0,
                items: items,
                onChanged: planChanged,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
