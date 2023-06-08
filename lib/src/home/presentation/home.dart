import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/src/cars/presentation/add_car.dart';
import 'package:rent_wheels_renter/src/cars/presentation/all_cars.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCar(),
                ),
              ),
              child: const ListTile(
                title: Text('Add Car'),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AllCars(),
                ),
              ),
              child: const ListTile(
                title: Text('All Cars'),
              ),
            ),
            buildGenericButtonWidget(
              buttonName: 'Logout',
              onPressed: () async {
                await AuthService.firebase().logout();
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false);
              },
            ),
            buildGenericButtonWidget(
              buttonName: 'Delete Account',
              onPressed: () async {
                await AuthService.firebase()
                    .deleteUser(user: FirebaseAuth.instance.currentUser!);

                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
