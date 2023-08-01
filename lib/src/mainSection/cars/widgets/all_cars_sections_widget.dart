import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

Widget buildAllCarsSections({
  required Car? car,
  required BuildContext context,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Hero(
      tag: car?.media?[0].mediaURL ?? '',
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: Sizes().height(context, 0.25),
        margin: EdgeInsets.only(bottom: Sizes().height(context, 0.02)),
        decoration: BoxDecoration(
          color: rentWheelsNeutralLight0,
          borderRadius: BorderRadius.circular(Sizes().height(context, 0.015)),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                image: car != null
                    ? DecorationImage(
                        image:
                            CachedNetworkImageProvider(car.media![0].mediaURL!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.15),
            ),
            Padding(
              padding: EdgeInsets.all(Sizes().height(context, 0.015)),
              child: Text(
                '${car?.yearOfManufacture} ${car?.make} ${car?.model}',
                style: heading4Neutral0,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
