import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car.dart';

import 'package:rent_wheels_renter/src/mainSection/home/presentation/home.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/all_cars.dart';
import 'package:rent_wheels_renter/src/mainSection/profile/presentation/profile.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/presentation/reservation.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/bottomNavbar/curved_bottom_navigation_bar_widget.dart';

class MainSection extends StatefulWidget {
  final int? pageIndex;
  const MainSection({super.key, this.pageIndex});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void setCurrentIndex() {
    if (widget.pageIndex != null) {
      setState(() {
        currentIndex = widget.pageIndex!;
      });
    }
  }

  static const List<Widget> _pages = [
    Home(),
    AllCars(),
    Reservations(),
    Profile(),
  ];

  @override
  void initState() {
    setCurrentIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: _pages.elementAt(currentIndex),
      bottomNavigationBar: Stack(
        children: [
          // BottomNavigationBar(
          //   type: BottomNavigationBarType.fixed,
          //   enableFeedback: true,
          //   elevation: 10,
          //   backgroundColor: rentWheelsNeutralLight0,
          //   onTap: changeIndex,
          //   currentIndex: currentIndex,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   items: [
          //     BottomNavigationBarItem(
          //       label: 'Dashboard',
          //       icon: SvgPicture.asset(
          //         currentIndex == 0
          //             ? 'assets/svgs/active_home.svg'
          //             : 'assets/svgs/inactive_home.svg',
          //         colorFilter: const ColorFilter.mode(
          //           rentWheelsBrandDark800,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'All Cars',
          //       icon: SvgPicture.asset(
          //         currentIndex == 1
          //             ? 'assets/svgs/active_car.svg'
          //             : 'assets/svgs/inactive_car.svg',
          //         colorFilter: const ColorFilter.mode(
          //           rentWheelsBrandDark900,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Reservations',
          //       icon: SvgPicture.asset(
          //         currentIndex == 2
          //             ? 'assets/svgs/active_reservation.svg'
          //             : 'assets/svgs/inactive_reservation.svg',
          //         colorFilter: const ColorFilter.mode(
          //           rentWheelsBrandDark900,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Profile',
          //       icon: SvgPicture.asset(
          //         currentIndex == 3
          //             ? 'assets/svgs/active_profile.svg'
          //             : 'assets/svgs/inactive_profile.svg',
          //         colorFilter: const ColorFilter.mode(
          //           rentWheelsBrandDark900,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          CurvedBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: changeIndex,
            items: [
              CurvedNavigationBarItem(
                activeImageAsset: 'assets/svgs/active_home.svg',
                inActiveImageAsset: 'assets/svgs/inactive_home.svg',
              ),
              CurvedNavigationBarItem(
                activeImageAsset: 'assets/svgs/active_car.svg',
                inActiveImageAsset: 'assets/svgs/inactive_car.svg',
              ),
              CurvedNavigationBarItem(
                activeImageAsset: 'assets/svgs/active_reservation.svg',
                inActiveImageAsset: 'assets/svgs/inactive_reservation.svg',
              ),
              CurvedNavigationBarItem(
                activeImageAsset: 'assets/svgs/active_profile.svg',
                inActiveImageAsset: 'assets/svgs/inactive_profile.svg',
              ),
            ],
          ),
          if (currentIndex != 3)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCar(type: CarReviewType.add),
                ),
              ),
              child: Center(
                heightFactor: .1,
                child: Container(
                  padding: EdgeInsets.all(Sizes().height(context, 0.005)),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(180)),
                    boxShadow: [
                      BoxShadow(
                        color: rentWheelsInformationDark900.withOpacity(0.4),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    width: Sizes().width(context, 0.16),
                    height: Sizes().height(context, 0.075),
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: rentWheelsInformationDark900,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: rentWheelsNeutralLight0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
