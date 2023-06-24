import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_image_widget.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_more_images_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';

class AddCarPageFour extends StatefulWidget {
  final Car carDetails;
  const AddCarPageFour({super.key, required this.carDetails});

  @override
  State<AddCarPageFour> createState() => _AddCarPageFourState();
}

class _AddCarPageFourState extends State<AddCarPageFour> {
  File? back;
  File? front;
  late List<Media> imageFiles;
  late List<File> additionalImageFiles;
  Car carDetails = Car();

  bool isActive() {
    return back != null && front != null;
  }

  //function to get image source and file
  Future getImage({required ImageSource source, String? type}) async {
    if (type == 'additional') {
      final List<XFile> images = await ImagePicker().pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          imageFiles.addAll(
            images.map((image) => Media(mediaURL: image.path)).toList(),
          );
          additionalImageFiles.addAll(images.map((image) => File(image.path)));
        });
      }
    } else {
      final file = await ImagePicker().pickImage(source: source);

      if (file?.path != null) {
        final image = File(file!.path);

        setState(() {
          if (type == 'front') {
            front = image;
            imageFiles[0] = Media(mediaURL: image.path);
          } else if (type == 'back') {
            back = image;
            imageFiles[1] = Media(mediaURL: image.path);
          }
        });
      }
    }
  }

  deleteImage({File? image, required String type}) {
    setState(() {
      if (type == 'front') {
        front = null;
        imageFiles[0] = Media(mediaURL: null);
      } else if (type == 'back') {
        back = null;
        imageFiles[1] = Media(mediaURL: null);
      } else {
        additionalImageFiles.removeWhere((img) => img == image);
        imageFiles.removeWhere((media) => media.mediaURL == image!.path);
      }
    });
  }

  bottomSheet({String? type}) {
    return mediaBottomSheet(
      context: context,
      cameraOnTap: () {
        getImage(source: ImageSource.camera, type: type);
        Navigator.of(context).pop();
      },
      galleryOnTap: () {
        getImage(source: ImageSource.gallery, type: type);
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    if (widget.carDetails.media != null &&
        widget.carDetails.media!.isNotEmpty) {
      additionalImageFiles = [];
      imageFiles = widget.carDetails.media!;
      if (imageFiles.first.mediaURL != null) {
        front = File(imageFiles.first.mediaURL!);
      }
      if (imageFiles.length > 1 && imageFiles[1].mediaURL != null) {
        back = File(imageFiles[1].mediaURL!);
      }
      if (imageFiles.length > 2) {
        additionalImageFiles =
            imageFiles.map((image) => File(image.mediaURL ?? "")).toList();
        additionalImageFiles.removeRange(0, 2);
      }
    } else {
      imageFiles = [Media(mediaURL: null), Media(mediaURL: null)];
      additionalImageFiles = [];
    }

    carDetails = widget.carDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () {
            carDetails.media = imageFiles;
            Navigator.pop(context, carDetails);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAddCarTop(context: context, page: 4),
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
                    selectImage: () => bottomSheet(type: 'front'),
                    deleteImage: () => deleteImage(type: 'front'),
                    imageFile: front,
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
                    selectImage: () => bottomSheet(type: 'back'),
                    deleteImage: () => deleteImage(type: 'back'),
                    imageFile: back,
                  ),
                  if (additionalImageFiles.isNotEmpty)
                    Space().height(context, 0.02),
                  if (additionalImageFiles.isNotEmpty)
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: Sizes().width(context, 0.02)),
                      child: const Text(
                        'Additional Images',
                        style: heading5Information,
                      ),
                    ),
                  ...additionalImageFiles.map((image) {
                    return Column(
                      children: [
                        buildCarImageUpload(
                          context: context,
                          selectImage: null,
                          deleteImage: () =>
                              deleteImage(type: 'additional', image: image),
                          imageFile: image,
                        ),
                        Space().height(context, 0.02),
                      ],
                    );
                  }).toList(),
                  if (isActive()) Space().height(context, 0.02),
                  if (isActive())
                    buildAddMorePhotos(
                      context: context,
                      onPressed: () => getImage(
                          source: ImageSource.gallery, type: 'additional'),
                    ),
                ],
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                context: context,
                width: Sizes().width(context, 0.85),
                isActive: isActive(),
                buttonName: "Continue",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
