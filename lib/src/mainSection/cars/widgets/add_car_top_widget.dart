import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

buildAddCarTop({
  required BuildContext context,
  required int page,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Add car',
        style: heading2Information,
      ),
      Space().height(context, 0.01),
      Text(
        'STEP $page OF 4',
        style: heading6Neutral500,
      ),
    ],
  );
}
