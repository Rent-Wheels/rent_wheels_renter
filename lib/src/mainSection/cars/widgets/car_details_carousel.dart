import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/carousel/carousel_dots_widget.dart';

buildCarImageCarousel({
  required int index,
  required List<Widget> items,
  required BuildContext context,
  //required CarouselController controller,
  required Function(int, CarouselPageChangedReason) onPageChanged,
}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: Sizes().height(context, 0.32),
          enableInfiniteScroll: items.length == 1 ? false : true,
          viewportFraction: 1,
          onPageChanged: onPageChanged,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.asMap().entries.map((entry) {
          return buildCarouselDots(
            index: entry.key,
            currentIndex: index,
            context: context,
          );
        }).toList(),
      )
    ],
  );
}
