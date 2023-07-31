import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/presentation/all_cars.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car_page_one.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AddCarPageOne(
                    type: CarReviewType.add,
                  ),
                ),
              ),
              child: const ListTile(
                title: Text('Add Car'),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AllCars(),
                ),
              ),
              child: const ListTile(
                title: Text('All Cars'),
              ),
            ),
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
    );
  }
}
