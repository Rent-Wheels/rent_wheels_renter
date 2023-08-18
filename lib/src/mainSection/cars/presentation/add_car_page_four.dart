import 'dart:io';

import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_image_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_more_images_widget.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

class AddCarPageFour extends StatefulWidget {
  final bool isActive;
  final Car carDetails;
  final CarReviewType type;
  final File? backImageFile;
  final File? frontImageFile;
  final String? backImageUrl;
  final String? frontImageUrl;
  final List<Media> imageFiles;
  final List<File?> additionalImageFiles;
  final List<String?> additionalImageUrls;
  final void Function() deleteBackImageOnPressed;
  final void Function() selectBackImageOnPressed;
  final void Function() deleteFrontImageOnPressed;
  final void Function() selectFrontImageOnPressed;
  final void Function() additionalImagesOnPressed;

  const AddCarPageFour({
    super.key,
    required this.type,
    required this.isActive,
    required this.carDetails,
    required this.imageFiles,
    required this.backImageUrl,
    required this.backImageFile,
    required this.frontImageUrl,
    required this.frontImageFile,
    required this.additionalImageUrls,
    required this.additionalImageFiles,
    required this.deleteBackImageOnPressed,
    required this.selectBackImageOnPressed,
    required this.deleteFrontImageOnPressed,
    required this.selectFrontImageOnPressed,
    required this.additionalImagesOnPressed,
  });

  @override
  State<AddCarPageFour> createState() => _AddCarPageFourState();
}

class _AddCarPageFourState extends State<AddCarPageFour> {
  deleteImage({File? image, String? imageUrl, required String type}) {
    setState(() {
      if (widget.additionalImageUrls.isNotEmpty) {
        widget.additionalImageUrls.removeWhere((img) => img == imageUrl);
        widget.imageFiles.removeWhere((media) => media.mediaURL == imageUrl);
      } else {
        widget.additionalImageFiles.removeWhere((img) => img == image);
        widget.imageFiles.removeWhere((media) => media.mediaURL == image!.path);
      }

      widget.carDetails.media = widget.imageFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAddCarTop(
                    context: context,
                    page: 4,
                    title: widget.type == CarReviewType.add
                        ? 'Add Car'
                        : 'Update Car',
                  ),
                  Space().height(context, 0.03),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
                    child: const Text(
                      'Front of Car',
                      style: heading5Information,
                    ),
                  ),
                  buildCarImageUpload(
                    context: context,
                    selectImage: widget.selectFrontImageOnPressed,
                    deleteImage: widget.deleteFrontImageOnPressed,
                    imageFile: widget.frontImageFile,
                    imageUrl: widget.frontImageUrl,
                  ),
                  Space().height(context, 0.02),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
                    child: const Text(
                      'Back of Car',
                      style: heading5Information,
                    ),
                  ),
                  buildCarImageUpload(
                    context: context,
                    selectImage: widget.selectBackImageOnPressed,
                    deleteImage: widget.deleteBackImageOnPressed,
                    imageFile: widget.backImageFile,
                    imageUrl: widget.backImageUrl,
                  ),
                  Space().height(context, 0.02),
                  if (widget.additionalImageFiles.isNotEmpty ||
                      widget.additionalImageUrls.isNotEmpty)
                    Column(
                      children: [
                        Space().height(context, 0.02),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: Sizes().width(context, 0.02)),
                          child: const Text(
                            'Additional Images',
                            style: heading5Information,
                          ),
                        ),
                      ],
                    ),
                  if (widget.additionalImageUrls.isNotEmpty)
                    ...widget.additionalImageUrls.map((image) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.02),
                        ),
                        child: buildCarImageUpload(
                          imageUrl: image,
                          context: context,
                          selectImage: null,
                          deleteImage: () => deleteImage(
                            type: 'additional',
                            imageUrl: image,
                          ),
                        ),
                      );
                    }).toList(),
                  if (widget.additionalImageFiles.isNotEmpty)
                    ...widget.additionalImageFiles.map((image) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.02),
                        ),
                        child: buildCarImageUpload(
                          context: context,
                          imageFile: image,
                          selectImage: null,
                          deleteImage: () =>
                              deleteImage(type: 'additional', image: image),
                        ),
                      );
                    }).toList(),
                  if (widget.isActive)
                    buildAddMorePhotos(
                      context: context,
                      onPressed: widget.additionalImagesOnPressed,
                    ),
                  Space().height(context, 0.1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
