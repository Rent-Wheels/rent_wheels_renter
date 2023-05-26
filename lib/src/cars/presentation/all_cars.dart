import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';

class AllCars extends StatefulWidget {
  const AllCars({super.key});

  @override
  State<AllCars> createState() => _AllCarsState();
}

class _AllCarsState extends State<AllCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: RentWheelsCarMethods().getAllCars(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();

              case ConnectionState.done:
                return snapshot.hasData
                    ? Cars(cars: snapshot.data!)
                    : Text(snapshot.error.toString());
              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }
}

class Cars extends StatefulWidget {
  final List<Car> cars;
  const Cars({super.key, required this.cars});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    final cars = widget.cars;
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
              '${global.baseURL}/${cars[index].media[0].mediaURL}'),
          title: Text(
              '${cars[index].yearOfManufacture} ${cars[index].make} ${cars[index].model}'),
        );
      },
    );
  }
}
