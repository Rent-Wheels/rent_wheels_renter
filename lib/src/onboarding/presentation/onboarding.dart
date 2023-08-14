import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/authentication/signup/presentation/signup.dart';
import 'package:rent_wheels_renter/src/onboarding/widgets/onboarding_slide_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/carousel/carousel_dots_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> slides = [
      buildOnboadingSlide(
        context: context,
        heading: "Unlock Your Car's Potential",
        imagePath: 'assets/images/onboarding_1.JPG',
        description:
            "Turn your car into extra cash! Join Rent Wheels and start renting out your vehicle with ease.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Revolutionize Car Ownership',
        imagePath: 'assets/images/onboarding_3.WEBP',
        description:
            "Discover a new way to own a car. Set up your listing in minutes and let your car pay for itself.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Drive, Earn, Repeat',
        imagePath: 'assets/images/onboarding_2.JPG',
        description:
            "Hit the road to earning potential. Start renting out your car today and watch your income accelerate.",
      ),
    ];
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(context, 0.04),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => setState(() {
                  currentIndex = value;
                }),
                itemBuilder: (context, index) {
                  return slides[index];
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => buildCarouselDots(
                        index: index,
                        context: context,
                        width: Sizes().width(context, 0.075),
                        currentIndex: currentIndex,
                        inactiveColor: rentWheelsBrandDark900Trans,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentIndex != slides.length - 1)
                        GestureDetector(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('firstTime', false);

                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SignUp(
                                  onboarding: true,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Skip',
                            style: body1Neutral500,
                          ),
                        ),
                      Space().width(context, 0.04),
                      buildGenericButtonWidget(
                        isActive: true,
                        context: context,
                        buttonName: currentIndex == slides.length - 1
                            ? 'Sign Up'
                            : 'Next',
                        width: Sizes().width(context, 0.25),
                        onPressed: () async {
                          if (currentIndex == slides.length - 1) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('firstTime', false);

                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SignUp(
                                  onboarding: true,
                                ),
                              ),
                            );
                          }
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
