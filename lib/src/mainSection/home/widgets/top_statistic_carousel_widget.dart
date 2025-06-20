import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';

Widget buildTopStatisticCarousel({
  required int index,
  required bool isLoading,
  required List<Widget>? items,
  required BuildContext context,
  //required CarouselController controller,
  required Function(int, CarouselPageChangedReason) onPageChanged,
}) {
  return isLoading
      ? Container(
          color: rentWheelsNeutralLight0,
          height: Sizes().height(context, 0.35),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: items,
              options: CarouselOptions(
                autoPlay: true,
                height: Sizes().height(context, 0.35),
                enableInfiniteScroll: items?.length == 1 ? false : true,
                viewportFraction: 1,
                onPageChanged: onPageChanged,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items!.asMap().entries.map((entry) {
                return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 200),
                  width: index == entry.key
                      ? Sizes().width(context, 0.1)
                      : Sizes().width(context, 0.03),
                  height: Sizes().height(context, 0.012),
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: ShapeDecoration(
                    shape: index == entry.key
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes().width(context, 0.03),
                            ),
                          )
                        : const CircleBorder(),
                    color: index == entry.key
                        ? rentWheelsBrandDark900
                        : rentWheelsBrandDark900Trans,
                  ),
                );
              }).toList(),
            )
          ],
        );
}
