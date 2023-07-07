import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/car_details.dart';
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
        child: StreamBuilder(
          stream: RentWheelsCarMethods().getAllCars(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Cars(cars: snapshot.data!);
            }

            if (snapshot.hasError) {
              Text(snapshot.error.toString());
            }

            return const CircularProgressIndicator();
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
        return InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CarDetails(car: cars[index]),
              )),
          child: ListTile(
            // leading: CachedNetworkImage(
            //     imageUrl: '${cars[index].media![0].mediaURL}'),
            title: Text(
                '${cars[index].yearOfManufacture} ${cars[index].make} ${cars[index].model}'),
          ),
        );
      },
    );
  }
}
