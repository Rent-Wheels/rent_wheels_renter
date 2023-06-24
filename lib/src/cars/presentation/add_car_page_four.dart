import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_car_image_widget.dart';
import 'package:rent_wheels_renter/src/cars/widgets/add_more_images_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';

class AddCarPageFour extends StatefulWidget {
  const AddCarPageFour({super.key});

  @override
  State<AddCarPageFour> createState() => _AddCarPageFourState();
}

class _AddCarPageFourState extends State<AddCarPageFour> {
  File? back;
  File? front;
  List<Media> imageFiles = [];
  List<File> additionalImageFiles = [];

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
            imageFiles.insert(0, Media(mediaURL: image.path));
          } else if (type == 'back') {
            back = image;
            imageFiles.insert(1, Media(mediaURL: image.path));
          }
        });
      }
    }
  }

  deleteImage({File? image, required String type}) {
    setState(() {
      if (type == 'front') {
        front = null;
        imageFiles.removeAt(0);
      } else if (type == 'back') {
        back = null;
        imageFiles.removeAt(1);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      onPressed: () => bottomSheet(type: 'additional'),
                    ),
                ],
              ),
              Space().height(context, 0.05),
              buildGenericButtonWidget(
                context: context,
                width: Sizes().width(context, 0.8),
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
