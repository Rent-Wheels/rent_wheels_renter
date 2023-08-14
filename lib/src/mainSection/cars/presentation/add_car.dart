import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels_renter/core/widgets/search/custom_search_bar.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';

import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_four.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_one.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_three.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_two.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_sucess.dart';
import 'package:string_validator/string_validator.dart';

class AddCar extends StatefulWidget {
  final Car? car;
  final CarReviewType type;
  const AddCar({super.key, this.car, required this.type});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  File? backImageFile;
  File? frontImageFile;
  String? backImageUrl;
  String? frontImageUrl;

  int currentIndex = 0;
  Car carDetails = Car();

  bool isMakeValid = false;
  bool isYearValid = false;
  bool isRateValid = false;
  bool isTypeValid = false;
  bool isModelValid = false;
  bool isColorValid = false;
  bool isTermsValid = false;
  bool isLocationValid = false;
  bool isCapacityValid = false;
  bool isConditionValid = false;
  bool isDescriptionValid = false;
  bool isMaxDurationValid = false;
  bool isRegistrationValid = false;

  List<File?> additionalImageFiles = [];
  List<String?> additionalImageUrls = [];
  List<Media> imageFiles = [Media(mediaURL: null), Media(mediaURL: null)];

  PageController carInformation = PageController();

  TextEditingController make = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController terms = TextEditingController();
  TextEditingController carType = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController maxDuration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController plan = TextEditingController(text: "/hr");
  TextEditingController yearOfManufacture = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();
  TextEditingController duration = TextEditingController(text: "days");

  setCarDetails() {
    Car car = widget.car!;

    carDetails = car;
    make.text = car.make!;
    plan.text = car.plan!;
    model.text = car.model!;
    color.text = car.color!;
    terms.text = car.terms!;
    imageFiles = car.media!;
    carDetails.plan = "/hr";
    carType.text = car.type!;
    carDetails.duration = "days";
    duration.text = car.duration!;
    location.text = car.location!;
    condition.text = car.condition!;
    rate.text = car.rate.toString();
    description.text = car.description!;
    backImageUrl = imageFiles[1].mediaURL!;
    capacity.text = car.capacity.toString();
    frontImageUrl = imageFiles.first.mediaURL!;
    maxDuration.text = car.maxDuration.toString();
    yearOfManufacture.text = car.yearOfManufacture!;
    registrationNumber.text = car.registrationNumber!;

    if (imageFiles.length > 2) {
      additionalImageUrls = imageFiles.map((image) {
        if (isURL(image.mediaURL!)) {
          return image.mediaURL ?? "";
        }
      }).toList();
      additionalImageUrls.removeRange(0, 2);
      additionalImageUrls.removeWhere((image) => image == null);
    }
  }

  bool pageOneIsValid() {
    return widget.car != null ||
        (isMakeValid &&
            isModelValid &&
            isColorValid &&
            isYearValid &&
            isRegistrationValid);
  }

  bool pageTwoIsValid() {
    return widget.car != null ||
        (isRateValid &&
            isTypeValid &&
            isCapacityValid &&
            isMaxDurationValid &&
            isConditionValid);
  }

  bool pageThreeIsValid() {
    return widget.car != null ||
        (isTermsValid && isLocationValid && isDescriptionValid);
  }

  bool pageFourIsValid() {
    return widget.car != null ||
        ((backImageFile != null && frontImageFile != null) ||
            (backImageUrl != null && frontImageUrl != null));
  }

  makeOnChanged(value) {
    final noSpaceValue = value.replaceAll(" ", "");
    if (noSpaceValue.length >= 3 && isAlpha(noSpaceValue)) {
      setState(() {
        isMakeValid = true;
        carDetails.make = value;
      });
    } else {
      setState(() {
        isMakeValid = false;
      });
    }
  }

  modelOnChanged(value) {
    final noSpaceValue = value.replaceAll(" ", "");
    if (noSpaceValue.length >= 2 && isAlphanumeric(noSpaceValue)) {
      setState(() {
        isModelValid = true;
        carDetails.model = value;
      });
    } else {
      setState(() {
        isModelValid = false;
      });
    }
  }

  colorOnChanged(value) {
    final noSpaceValue = value.replaceAll(" ", "");
    if (noSpaceValue.length >= 3 && isAlpha(noSpaceValue)) {
      setState(() {
        isColorValid = true;
        carDetails.color = value;
      });
    } else {
      setState(() {
        isColorValid = false;
      });
    }
  }

  yearOnChanged(value) {
    if (num.parse(value) >= 1970 && num.parse(value) <= DateTime.now().year) {
      setState(() {
        isYearValid = true;
        carDetails.yearOfManufacture = value;
      });
    } else {
      setState(() {
        isYearValid = false;
      });
    }
  }

  registrationOnChanged(value) {
    final registrationRegexp =
        RegExp(r'^[A-Z]{2}\s\d{1,4}(\s[A-Z]{1}|-[0][9]|-[1][0-9]|-[2][0-3])$');
    if (registrationRegexp.hasMatch(value)) {
      setState(() {
        isRegistrationValid = true;
        carDetails.registrationNumber = value;
      });
    } else {
      setState(() {
        isRegistrationValid = false;
      });
    }
  }

  carTypeOnChanged(value) {
    if (value.isNotEmpty) {
      setState(() {
        carType.text = value;
        isTypeValid = true;
        carDetails.type = value;
      });
    } else {
      setState(() {
        isTypeValid = false;
      });
    }
  }

  seatOnChanged(value) {
    if (value.isNotEmpty &&
        value.length <= 2 &&
        int.parse(value) != 0 &&
        isNumeric(value)) {
      setState(() {
        isCapacityValid = true;
        carDetails.capacity = num.parse(value);
      });
    } else {
      setState(() {
        isCapacityValid = false;
      });
    }
  }

  carConditionOnChanged(value) {
    if (value.isNotEmpty) {
      setState(() {
        condition.text = value;
        isConditionValid = true;
        carDetails.condition = value;
      });
    } else {
      setState(() {
        isConditionValid = false;
      });
    }
  }

  rentalPlanOnChanged(value) {
    if (value.isNotEmpty) {
      setState(() {
        plan.text = value;
        carDetails.plan = value;
      });
    }
  }

  rentalRateOnChanged(value) {
    if (isNumeric(value) && num.parse(value) > 0) {
      setState(() {
        isRateValid = true;
        carDetails.rate = num.parse(value);
      });
    } else {
      setState(() {
        isRateValid = false;
      });
    }
  }

  rentalDurationOnChanged(value) {
    if (value.isNotEmpty) {
      setState(() {
        duration.text = value;
        carDetails.duration = value;
      });
    }
  }

  maxDurationOnChanged(value) {
    if (isNumeric(value) && num.parse(value) > 0) {
      setState(() {
        isMaxDurationValid = true;
        carDetails.maxDuration = num.parse(value);
      });
    } else {
      setState(() {
        isMaxDurationValid = false;
      });
    }
  }

  locationOnTap() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CustomSearchScaffold(),
      ),
    );

    if (result != null) {
      setState(() {
        location.text = result;
        isLocationValid = true;
        carDetails.location = result;
      });
    }
  }

  tcOnChanged(value) {
    final noSpaces = value.replaceAll(" ", "");
    if (noSpaces.isNotEmpty && noSpaces.length > 10) {
      setState(() {
        isTermsValid = true;
        carDetails.terms = value;
      });
    } else {
      setState(() {
        isTermsValid = false;
      });
    }
  }

  descriptionOnChanged(value) {
    final noSpaces = value.replaceAll(" ", "");
    if (noSpaces.isNotEmpty && noSpaces.length > 10) {
      setState(() {
        isDescriptionValid = true;
        carDetails.description = value;
      });
    } else {
      setState(() {
        isDescriptionValid = false;
      });
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

  Future addCar() async {
    buildLoadingIndicator(context, 'Adding Car');

    try {
      final car =
          await RentWheelsCarMethods().addNewCar(carDetails: carDetails);
      if (!mounted) return;
      Navigator.pop(context);
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
      Navigator.pop(context);
      showSuccessPopUp('Car has been updated successfully!', context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showErrorPopUp(e.toString(), context);
    }
  }

  deleteImage({File? image, String? imageUrl, required String type}) {
    setState(() {
      if (type == 'front') {
        frontImageFile != null ? frontImageFile = null : frontImageUrl = null;
        imageFiles[0] = Media(mediaURL: null);
      } else if (type == 'back') {
        backImageFile != null ? backImageFile = null : backImageUrl = null;
        imageFiles[1] = Media(mediaURL: null);
      } else {
        if (additionalImageUrls.isNotEmpty) {
          additionalImageUrls.removeWhere((img) => img == imageUrl);
          imageFiles.removeWhere((media) => media.mediaURL == imageUrl);
        } else {
          additionalImageFiles.removeWhere((img) => img == image);
          imageFiles.removeWhere((media) => media.mediaURL == image!.path);
        }
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

  @override
  void initState() {
    if (widget.car != null) {
      setCarDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      AddCarPageOne(
        make: make,
        model: model,
        color: color,
        car: widget.car,
        type: widget.type,
        makeOnChanged: makeOnChanged,
        yearOnChanged: yearOnChanged,
        modelOnChanged: modelOnChanged,
        colorOnChanged: colorOnChanged,
        yearOfManufacture: yearOfManufacture,
        registrationNumber: registrationNumber,
        registrationOnChanged: registrationOnChanged,
      ),
      AddCarPageTwo(
        plan: plan,
        rate: rate,
        carType: carType,
        type: widget.type,
        capacity: capacity,
        duration: duration,
        condition: condition,
        maxDuration: maxDuration,
        seatOnChanged: seatOnChanged,
        carTypeOnChanged: carTypeOnChanged,
        rentalRateOnChanged: rentalRateOnChanged,
        rentalPlanOnChanged: rentalPlanOnChanged,
        maxDurationOnChanged: maxDurationOnChanged,
        carConditionOnChanged: carConditionOnChanged,
        rentalDurationOnChanged: rentalDurationOnChanged,
      ),
      AddCarPageThree(
        type: widget.type,
        terms: terms,
        location: location,
        description: description,
        tcOnChanged: tcOnChanged,
        locationOnTap: locationOnTap,
        descriptionOnChanged: descriptionOnChanged,
      ),
      AddCarPageFour(
        carDetails: carDetails,
        type: widget.type,
        isActive: pageFourIsValid(),
        imageFiles: imageFiles,
        backImageUrl: backImageUrl,
        backImageFile: backImageFile,
        frontImageUrl: frontImageUrl,
        frontImageFile: frontImageFile,
        additionalImageUrls: additionalImageUrls,
        additionalImageFiles: additionalImageFiles,
        deleteBackImageOnPressed: () => deleteImage(type: 'back'),
        selectBackImageOnPressed: () => bottomSheet(type: 'back'),
        deleteFrontImageOnPressed: () => deleteImage(type: 'front'),
        selectFrontImageOnPressed: () => bottomSheet(type: 'front'),
        additionalImagesOnPressed: () =>
            getImage(source: ImageSource.gallery, type: 'additional'),
      )
    ];

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () {
            if (currentIndex == 0) {
              Navigator.pop(context);
            } else {
              carInformation.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
        ),
      ),
      body: PageView.builder(
        controller: carInformation,
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
      bottomSheet: Container(
        height: Sizes().height(context, 0.12),
        width: double.infinity,
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.all(Sizes().height(context, 0.01)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildGenericButtonWidget(
              context: context,
              isActive: currentIndex == 0
                  ? pageOneIsValid()
                  : currentIndex == 1
                      ? pageTwoIsValid()
                      : currentIndex == 2
                          ? pageThreeIsValid()
                          : pageFourIsValid(),
              width: Sizes().width(context, 0.85),
              buttonName: currentIndex != pages.length - 1
                  ? 'Continue'
                  : widget.type == CarReviewType.add
                      ? 'Add Car'
                      : 'Update Car',
              onPressed: () async {
                if (currentIndex != pages.length - 1) {
                  carInformation.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                } else {
                  widget.type == CarReviewType.add ? addCar() : updateCar();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
