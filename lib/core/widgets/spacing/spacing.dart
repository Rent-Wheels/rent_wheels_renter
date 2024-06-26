import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';

class Space {
  //custom spacing height
  height(BuildContext context, double size) {
    return SizedBox(
      height: Sizes().height(context, size),
    );
  }

  //custom spacing width

  width(BuildContext context, double size) {
    return SizedBox(
      width: Sizes().width(context, size),
    );
  }
}
