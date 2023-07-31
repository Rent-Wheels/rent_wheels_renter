import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

Widget buildCarImageUpload({
  File? imageFile,
  String? imageUrl,
  required BuildContext context,
  required void Function()? selectImage,
  required void Function() deleteImage,
}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    height: Sizes().height(context, 0.2),
    decoration: BoxDecoration(
      border: Border.all(
        color: rentWheelsNeutralLight200,
      ),
      borderRadius: BorderRadius.circular(
        Sizes().width(context, 0.045),
      ),
    ),
    child: Stack(
      children: [
        GestureDetector(
          onTap: selectImage,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: Sizes().height(context, 0.2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: rentWheelsNeutralLight200,
                  ),
                  borderRadius: BorderRadius.circular(
                    Sizes().width(context, 0.045),
                  ),
                ),
              ),
              if (imageFile == null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_outlined,
                      color: rentWheelsInformationDark900,
                    ),
                    Space().height(context, 0.005),
                    const Text(
                      'Add your photo here.',
                      style: body1Neutral500,
                    )
                  ],
                ),
            ],
          ),
        ),
        Stack(
          children: [
            GestureDetector(
              onTap: selectImage,
              child: Container(
                height: Sizes().height(context, 0.2),
                decoration: BoxDecoration(
                  image: imageFile != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(imageFile),
                        )
                      : imageUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(imageUrl),
                            )
                          : null,
                  border: Border.all(
                    color: rentWheelsNeutralLight200,
                  ),
                  borderRadius: BorderRadius.circular(
                    Sizes().width(context, 0.045),
                  ),
                ),
              ),
            ),
            if (imageFile != null || imageUrl != null)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: deleteImage,
                  child: Container(
                    color: rentWheelsNeutralLight0,
                    child: Icon(
                      Icons.delete,
                      color: rentWheelsErrorDark700,
                      size: Sizes().height(context, 0.03),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
