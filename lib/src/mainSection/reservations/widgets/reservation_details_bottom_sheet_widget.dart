import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

buildReservationDetailsBottomSheet({
  required BuildContext context,
  required void Function() onAccept,
  required void Function() onDecline,
}) {
  return Container(
    color: rentWheelsNeutralLight0,
    padding: EdgeInsets.all(Sizes().height(context, 0.02)),
    height: Sizes().height(context, 0.13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGenericButtonWidget(
          isActive: true,
          context: context,
          onPressed: onAccept,
          buttonName: '✓ Accept',
          width: Sizes().width(context, 0.4),
          btnColor: rentWheelsSuccessDark700,
        ),
        buildGenericButtonWidget(
          isActive: true,
          context: context,
          onPressed: onDecline,
          buttonName: 'x Decline',
          btnColor: rentWheelsErrorDark700,
          width: Sizes().width(context, 0.4),
        ),
      ],
    ),
  );
}
