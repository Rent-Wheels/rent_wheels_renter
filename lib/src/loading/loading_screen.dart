import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Image.asset('assets/images/launch-image.png'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: Sizes().height(context, 0.05)),
              height: Sizes().height(context, 0.1),
              child: const LoadingIndicator(
                indicatorType: Indicator.ballTrianglePathColored,
                colors: [
                  rentWheelsBrandDark900,
                  rentWheelsBrandDark700,
                  rentWheelsBrand
                ],
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
