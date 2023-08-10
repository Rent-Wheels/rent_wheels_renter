import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';

import 'package:rent_wheels_renter/src/mainSection/home/data/dashboard_data.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space().height(context, 0.04),
              const Text(
                "Dashboard",
                style: heading3Information,
              ),
              Space().height(context, 0.03),
              const Expanded(
                child: SingleChildScrollView(
                  child: DashboardData(),
                ),
              ),
              // GestureDetector(
              //   onTap: () => Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //       builder: (context) => const AddCarPageOne(
              //         type: CarReviewType.add,
              //       ),
              //     ),
              //   ),
              //   child: const ListTile(
              //     title: Text('Add Car'),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () => Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //       builder: (context) => const AllCars(),
              //     ),
              //   ),
              //   child: const ListTile(
              //     title: Text('All Cars'),
              //   ),
              // ),
              // buildGenericButtonWidget(
              //   buttonName: 'Delete Account',
              //   onPressed: () async {
              //     await AuthService.firebase()
              //         .deleteUser(user: FirebaseAuth.instance.currentUser!);

              //     if (!mounted) return;
              //     Navigator.pushAndRemoveUntil(context,
              //         CupertinoPageRoute(builder: (context) => const Login()),
              //         (route) => false);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
