import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';

class CurvedBottomNavigationBar extends StatelessWidget {
  const CurvedBottomNavigationBar({
    super.key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<CurvedNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurvedClipper(),
      child: Container(
        height: kToolbarHeight * 1.5,
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().height(context, 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
                padding: EdgeInsets.only(
                  bottom: Sizes().height(context, 0.02),
                ),
                child: GestureDetector(
                  onTap: () => onTap?.call(index),
                  child: SvgPicture.asset(
                    index == currentIndex
                        ? item.activeImageAsset
                        : item.inActiveImageAsset,
                    colorFilter: const ColorFilter.mode(
                      rentWheelsBrandDark900,
                      BlendMode.srcIn,
                    ),
                  ),
                ));
          })
            ..insert(2, const SizedBox()),
        ),
      ),
    );
  }
}

class CurvedNavigationBarItem {
  String activeImageAsset;
  String inActiveImageAsset;

  CurvedNavigationBarItem({
    required this.activeImageAsset,
    required this.inActiveImageAsset,
  });
}

class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..quadraticBezierTo(size.width * 0.5, kToolbarHeight, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
