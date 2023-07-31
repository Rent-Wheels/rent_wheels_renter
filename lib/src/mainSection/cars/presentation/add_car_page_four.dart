import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_top_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_sucess.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_car_image_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/add_more_images_widget.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';

class AddCarPageFour extends StatefulWidget {
  final Car carDetails;
  final CarReviewType type;
  const AddCarPageFour(
      {super.key, required this.carDetails, required this.type});

  @override
  State<AddCarPageFour> createState() => _AddCarPageFourState();
}

class _AddCarPageFourState extends State<AddCarPageFour> {
  File? backImageFile;
  File? frontImageFile;

  String? frontImageUrl;
  String? backImageUrl;

  late List<Media> imageFiles;
  late List<File?> additionalImageFiles;
  late List<String?> additionalImageUrls;
  Car carDetails = Car();

  bool isActive() {
    return (backImageFile != null && frontImageFile != null) ||
        (backImageUrl != null && frontImageUrl != null);
  }

  getExistingImages() {
    if (widget.carDetails.media != null &&
        widget.carDetails.media!.isNotEmpty) {
      additionalImageUrls = [];
      additionalImageFiles = [];
      imageFiles = widget.carDetails.media!;
      if (imageFiles.first.mediaURL != null) {
        !isURL(imageFiles.first.mediaURL!)
            ? frontImageFile = File(imageFiles.first.mediaURL!)
            : frontImageUrl = imageFiles.first.mediaURL!;
      }
      if (imageFiles.length > 1 && imageFiles[1].mediaURL != null) {
        !isURL(imageFiles[1].mediaURL!)
            ? backImageFile = File(imageFiles[1].mediaURL!)
            : backImageUrl = imageFiles[1].mediaURL!;
      }
      if (imageFiles.length > 2) {
        additionalImageFiles = imageFiles.map((image) {
          if (!isURL(image.mediaURL!)) {
            return File(image.mediaURL ?? "");
          }
        }).toList();

        additionalImageUrls = imageFiles.map((image) {
          if (isURL(image.mediaURL!)) {
            return image.mediaURL ?? "";
          }
        }).toList();

        additionalImageFiles.removeRange(0, 2);
        additionalImageUrls.removeRange(0, 2);

        additionalImageFiles.removeWhere((image) => image == null);
        additionalImageUrls.removeWhere((image) => image == null);
      }
    } else {
      imageFiles = [Media(mediaURL: null), Media(mediaURL: null)];
      additionalImageUrls = [];
      additionalImageFiles = [];
    }
  }

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
            frontImageFile = image;
            imageFiles[0] = Media(mediaURL: image.path);
          } else if (type == 'back') {
            backImageFile = image;
            imageFiles[1] = Media(mediaURL: image.path);
          }
        });
      }
    }

    setState(() {
      carDetails.media = imageFiles;
    });
  }

  deleteImage({File? image, required String type}) {
    setState(() {
      if (type == 'front') {
        frontImageFile = null;
        imageFiles[0] = Media(mediaURL: null);
      } else if (type == 'back') {
        backImageFile = null;
        imageFiles[1] = Media(mediaURL: null);
      } else {
        additionalImageFiles.removeWhere((img) => img == image);
        imageFiles.removeWhere((media) => media.mediaURL == image!.path);
      }

      carDetails.media = imageFiles;
    });
  }

  bottomSheet({String? type}) {
    return mediaBottomSheet(
      context: context,
      cameraOnTap: () {
        getImage(source: ImageSource.camera, type: type);
        Navigator.pop(context);
      },
      galleryOnTap: () {
        getImage(source: ImageSource.gallery, type: type);
        Navigator.pop(context);
      },
    );
  }

  Future addCar() async {
    buildLoadingIndicator(context, 'Adding Car');

    try {
      final car =
          await RentWheelsCarMethods().addNewCar(carDetails: carDetails);
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => AddCarSuccess(carDetails: car),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  Future updateCar() async {
    buildLoadingIndicator(context, 'Updating Car Details');

    try {
      await RentWheelsCarMethods().updateCarDetails(carDetails: carDetails);
      if (!mounted) return;
      Navigator.pop(context);
      showSuccessPopUp('Car has been updated successfully!', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  @override
  void initState() {
    getExistingImages();
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
            Navigator.pop(context, carDetails);
          },
        ),
      ),
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
                    selectImage: () => bottomSheet(type: 'front'),
                    deleteImage: () => deleteImage(type: 'front'),
                    imageFile: frontImageFile,
                    imageUrl: frontImageUrl,
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
                    imageFile: backImageFile,
                    imageUrl: backImageUrl,
                  ),
                  Space().height(context, 0.02),
                  if (additionalImageFiles.isNotEmpty ||
                      additionalImageUrls.isNotEmpty)
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
                  if (additionalImageUrls.isNotEmpty)
                    ...additionalImageUrls.map((image) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.02),
                        ),
                        child: buildCarImageUpload(
                          context: context,
                          selectImage: null,
                          deleteImage: () {},
                          imageUrl: image,
                        ),
                      );
                    }).toList(),
                  if (additionalImageFiles.isNotEmpty)
                    ...additionalImageFiles.map((image) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.02),
                        ),
                        child: buildCarImageUpload(
                          context: context,
                          selectImage: null,
                          deleteImage: () =>
                              deleteImage(type: 'additional', image: image),
                          imageFile: image,
                        ),
                      );
                    }).toList(),
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
                width: double.infinity,
                isActive: isActive(),
                buttonName:
                    widget.type == CarReviewType.add ? 'Add Car' : 'Update Car',
                onPressed:
                    widget.type == CarReviewType.add ? addCar : updateCar,
              ),
              Space().height(context, 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
