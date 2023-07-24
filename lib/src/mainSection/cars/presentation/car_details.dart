// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
// import 'package:rent_wheels_renter/core/models/car/car_model.dart';
// import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';
// import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
// import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

// import '../../../../core/widgets/theme/colors.dart';

// class CarDetails extends StatefulWidget {
//   final Car car;
//   const CarDetails({super.key, required this.car});

//   @override
//   State<CarDetails> createState() => _CarDetailsState();
// }

// class _CarDetailsState extends State<CarDetails> {
//   TextEditingController make = TextEditingController();
//   TextEditingController model = TextEditingController();
//   TextEditingController capacity = TextEditingController();
//   TextEditingController yearOfManufacture = TextEditingController();
//   TextEditingController registrationNumber = TextEditingController();
//   TextEditingController condition = TextEditingController();
//   TextEditingController rate = TextEditingController();
//   TextEditingController plan = TextEditingController();
//   TextEditingController type = TextEditingController();
//   TextEditingController availability = TextEditingController();
//   TextEditingController location = TextEditingController();
//   TextEditingController maxDuration = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController terms = TextEditingController();

//   List<Media> media = [];
//   final mediaPicker = ImagePicker();

//   chooseImages() async {
//     final List<XFile> images = await mediaPicker.pickMultiImage();
//     if (images.isNotEmpty) {
//       media.addAll(images.map((image) => Media(mediaURL: image.path)).toList());
//     }
//     setState(() {});
//   }

//   final CarouselController _carouselController = CarouselController();

//   @override
//   void initState() {
//     make = TextEditingController(text: widget.car.make);
//     model = TextEditingController(text: widget.car.model);
//     capacity = TextEditingController(text: widget.car.capacity.toString());
//     yearOfManufacture =
//         TextEditingController(text: widget.car.yearOfManufacture);
//     registrationNumber =
//         TextEditingController(text: widget.car.registrationNumber);
//     condition = TextEditingController(text: widget.car.condition);
//     rate = TextEditingController(text: widget.car.rate.toString());
//     plan = TextEditingController(text: widget.car.plan);
//     type = TextEditingController(text: widget.car.type);
//     availability =
//         TextEditingController(text: widget.car.availability.toString());
//     location = TextEditingController(text: widget.car.location);
//     maxDuration =
//         TextEditingController(text: widget.car.maxDuration.toString());
//     description = TextEditingController(text: widget.car.description);
//     terms = TextEditingController(text: widget.car.terms);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List media = widget.car.media!;
//     debugPrint(media.length.toString());
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Space().height(context, .05),
//             CarouselSlider(
//               items: [
//                 for (Media item in media)
//                   Stack(children: [
//                     buildPromoCarouselItem(
//                         context: context, image: item.mediaURL!),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               widget.car.media!.removeWhere(
//                                   (m) => m.mediaURL == item.mediaURL);
//                             });
//                           },
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ])
//               ],
//               carouselController: _carouselController,
//               options: CarouselOptions(
//                 height: Sizes().height(context, 0.35),
//                 autoPlay: media.length == 1 ? false : true,
//                 enableInfiniteScroll: media.length == 1 ? false : true,
//                 viewportFraction: 1,
//                 onPageChanged: (index, _) {},
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Column(children: [
//                 BuildUpdateField(lable: 'Make', controller: make),
//                 BuildUpdateField(lable: 'Model', controller: model),
//                 BuildUpdateField(lable: 'Capacity', controller: capacity),
//                 BuildUpdateField(
//                     lable: 'Manufacture year', controller: yearOfManufacture),
//                 BuildUpdateField(
//                     lable: 'Registeration No.', controller: registrationNumber),
//                 BuildUpdateField(lable: 'Condition', controller: condition),
//                 BuildUpdateField(lable: 'Rate', controller: rate),
//                 BuildUpdateField(lable: 'Plan', controller: plan),
//                 BuildUpdateField(lable: 'Type', controller: type),
//                 BuildUpdateField(
//                     lable: 'Availability', controller: availability),
//                 BuildUpdateField(lable: 'Location', controller: location),
//                 BuildUpdateField(lable: 'MaxDuration', controller: maxDuration),
//                 BuildUpdateField(lable: 'Description', controller: description),
//                 BuildUpdateField(lable: 'Terms', controller: terms),
//               ]),
//             )
//             // ...widget.car.media!.map(
//             //   (media) {
//             //     return Stack(
//             //       children: [
//             //         CachedNetworkImage(
//             //           imageUrl: media.mediaURL!,
//             //           fit: BoxFit.cover,
//             //         ),
//             //         Positioned(
//             //           top: 0,
//             //           right: 0,
//             //           child: Container(
//             //             color: Colors.white,
//             //             child:
//             // GestureDetector(
//             //               onTap: () {
//             //                 setState(() {
//             //                   widget.car.media!.removeWhere(
//             //                       (m) => m.mediaURL == media.mediaURL);
//             //                 });
//             //               },
//             //               child: const Icon(
//             //                 Icons.delete,
//             //                 color: Colors.red,
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       ],
//             //     );
//             //   },
//             // ).toList(),
//             // ...media
//             //     .map((media) => Image.file(
//             //           File(media.mediaURL!),
//             //           fit: BoxFit.cover,
//             //         ))
//             //     .toList(),
//             // buildGenericButtonWidget(
//             //   isActive: true,
//             //   context: context,
//             //   onPressed: chooseImages,
//             //   buttonName: 'Select Images',
//             //   width: Sizes().width(context, 0.85),
//             // ),
//             // buildGenericButtonWidget(
//             //   isActive: true,
//             //   context: context,
//             //   buttonName: 'Update Car',
//             //   width: Sizes().width(context, 0.85),
//             //   onPressed: () async {
//             //     Car carDetails = Car(
//             //       carId: widget.car.carId,
//             //       make: make.text,
//             //       model: model.text,
//             //       capacity: int.parse(capacity.text),
//             //       color: widget.car.color,
//             //       yearOfManufacture: yearOfManufacture.text,
//             //       registrationNumber: registrationNumber.text,
//             //       condition: condition.text,
//             //       rate: int.parse(rate.text),
//             //       plan: plan.text,
//             //       type: type.text,
//             //       availability: bool.parse(availability.text),
//             //       location: location.text,
//             //       maxDuration: int.parse(maxDuration.text),
//             //       description: description.text,
//             //       terms: terms.text,
//             //       duration: 'days',
//             //       media: [...widget.car.media!, ...media],
//             //     );

//             //     await RentWheelsCarMethods()
//             //         .updateCarDetails(carDetails: carDetails);
//             //   },
//             // ),
//             // buildGenericButtonWidget(
//             //   buttonName: 'Delete Car',
//             //   onPressed: () async {
//             //     final response = await RentWheelsCarMethods()
//             //         .deleteCar(carId: widget.car.carId!);
//             //     if (response == Status.success) {
//             //       if (!mounted) return;
//             //       Navigator.pop(context);
//             //     }
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// buildPromoCarouselItem({
//   required String image,
//   required BuildContext context,
// }) {
//   return Container(
//     margin: EdgeInsets.symmetric(
//       horizontal: Sizes().width(context, 0.01),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: Sizes().height(context, 0.28),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 Sizes().width(context, 0.05),
//               ),
//             ),
//             image: DecorationImage(
//               image: NetworkImage(image),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// class BuildUpdateField extends StatefulWidget {
//   final TextEditingController controller;
//   final String lable;
//   const BuildUpdateField(
//       {super.key, required this.controller, required this.lable});

//   @override
//   State<BuildUpdateField> createState() => _BuildUpdateFieldState();
// }

// class _BuildUpdateFieldState extends State<BuildUpdateField> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         height: 40,
//         width: Sizes().width(context, 1) - 20,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: rentWheelsBrand,
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   widget.lable,
//                   style: heading4Information.copyWith(fontSize: 14),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Container(
//                 margin: const EdgeInsets.all(3.0),
//                 height: 30,
//                 width: Sizes().width(context, 1),
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: TextField(
//                     controller: widget.controller,
//                     style: body1Brand,
//                     decoration: const InputDecoration(border: InputBorder.none),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_one.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_carousel.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_carousel_items.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_key_value.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  // final Renter renter;
  final String? heroTag;

  const CarDetails(
      {super.key,
      required this.car,
      // required this.renter,
      this.heroTag});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int _carImageIndex = 0;
  bool changeColor = false;

  final ScrollController scroll = ScrollController();
  final CarouselController _carImage = CarouselController();

  @override
  void initState() {
    scroll.addListener(() {
      setState(() {
        if (scroll.offset < 196) {
          changeColor = false;
        } else {
          changeColor = true;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Car car = widget.car;
    List<Widget> carouselItems = widget.car.media!.map((media) {
      return buildCarDetailsCarouselItem(
          image: media.mediaURL!, context: context);
    }).toList();

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          SliverAppBar(
            backgroundColor: rentWheelsNeutralLight0,
            foregroundColor:
                !changeColor ? rentWheelsNeutralLight0 : rentWheelsBrandDark900,
            elevation: 0,
            leading: buildAdaptiveBackButton(
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            expandedHeight: Sizes().height(context, 0.3),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.heroTag ?? car.media![0].mediaURL!,
                    child: GestureDetector(
                      // onTap: () => Navigator.pop(context),
                      child: buildCarImageCarousel(
                        index: _carImageIndex,
                        items: carouselItems,
                        context: context,
                        controller: _carImage,
                        onPageChanged: (index, _) {
                          setState(() {
                            _carImageIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Sizes().width(context, 0.04),
                    right: Sizes().width(context, 0.04),
                    top: Sizes().height(context, 0.01),
                    bottom: Sizes().width(context, 0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.yearOfManufacture} ${car.make} ${car.model}',
                        style: heading3Information,
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.description!,
                        style: body1Neutral900,
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Vehicle Details',
                        style: heading4Information,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Registration Number',
                        value: car.registrationNumber!,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Color',
                        value: car.color!,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Number of Seats',
                        value: car.capacity.toString(),
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Type',
                        value: car.type!,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Condition',
                        value: car.condition!,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Location',
                        value: car.location!,
                      ),
                      Space().height(context, 0.01),
                      buildCarDetailsKeyValue(
                        context: context,
                        label: 'Rate',
                        value: 'GH¢${car.rate!} ${car.plan}',
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Terms & Conditions',
                        style: heading4Information,
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.terms!,
                        style: body1Neutral900,
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Renter Details',
                        style: heading4Information,
                      ),
                      // Space().height(context, 0.01),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: buildGenericButtonWidget(
        width: Sizes().width(context, 0.26),
        isActive: car.availability!,
        buttonName: 'Update Car',
        context: context,
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const AddCarPageOne(title: 'Updating car'),
          ),
        ),
      ),
      // bottomSheet: Container(
      //   color: rentWheelsNeutralLight0,
      //   padding: EdgeInsets.all(Sizes().height(context, 0.02)),
      //   height: Sizes().height(context, 0.13),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             '${car.yearOfManufacture} ${car.make} ${car.model}',
      //             style: heading4Information,
      //           ),
      //           Space().height(context, 0.01),
      //           Text(
      //             'GH¢${car.rate} ${car.plan}',
      //             style: body1Information,
      //           ),
      //         ],
      //       ),

      //     ],
      //   ),
      // ),
    );
  }
}
