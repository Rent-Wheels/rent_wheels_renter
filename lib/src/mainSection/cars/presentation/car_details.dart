import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_carousel.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_one.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_key_value.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_details_carousel_items.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/car_reservations_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/presentation/reservation_details.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  final String? heroTag;
  final List<Reservation> reservations;

  const CarDetails({
    super.key,
    this.heroTag,
    required this.car,
    required this.reservations,
  });

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int _carImageIndex = 0;
  bool changeColor = false;

  final ScrollController scroll = ScrollController();
  final CarouselController _carImage = CarouselController();

  @override
  Widget build(BuildContext context) {
    scroll.addListener(() {
      if (scroll.offset < 196) {
        setState(() {
          changeColor = false;
        });
      } else {
        setState(() {
          changeColor = true;
        });
      }
    });

    Car car = widget.car;
    List<Reservation> reservations = widget.reservations;

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
                      if (reservations.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reservations',
                              style: heading4Information,
                            ),
                            Space().height(context, 0.01),
                            ...reservations.map(
                              (reservation) => buildCarReservations(
                                context: context,
                                status: reservation.status,
                                customer: reservation.customer,
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ReservationDetails(
                                      car: car,
                                      customer: reservation.customer,
                                      reservation: reservation,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
          isActive: true,
          buttonName: 'Update Car',
          context: context,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddCarPageOne(
                  type: CarReviewType.update,
                  car: car,
                ),
              ),
            );
          }),
      // buildGenericButtonWidget(
      //   buttonName: 'Delete Car',
      //   onPressed: () async {
      //     final response = await RentWheelsCarMethods()
      //         .deleteCar(carId: widget.car.carId!);
      //     if (response == Status.success) {
      //       if (!mounted) return;
      //       Navigator.pop(context);
      //     }
      //   },
      // ),
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
