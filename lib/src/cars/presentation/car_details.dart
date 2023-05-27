import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;

class CarDetails extends StatelessWidget {
  final Car car;
  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network('${global.baseURL}/${car.media[0].mediaURL}'),
          Text('${car.yearOfManufacture} ${car.make} ${car.model}'),
          Text('(${car.type})${car.registrationNumber}')
        ],
      ),
    );
  }
}
