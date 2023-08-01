import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:rent_wheels_renter/src/mainSection/cars/presentation/car_details.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/all_cars_sections_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AllCarsData extends StatefulWidget {
  const AllCarsData({super.key});

  @override
  State<AllCarsData> createState() => _AllCarsDataState();
}

class _AllCarsDataState extends State<AllCarsData> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return FutureBuilder(
      future: RentWheelsCarMethods().getAllCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car> cars = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cars
                .map(
                  (car) => buildAllCarsSections(
                    car: car,
                    context: context,
                    onTap: () async {
                      final reservations = await RentWheelsCarMethods()
                          .getCarRentalHistory(carId: car.carId!);

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CarDetails(
                            car: car,
                            reservations: reservations,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        }

        if (snapshot.hasError) {
          Text(snapshot.error.toString());
        }

        return SizedBox(
          height: Sizes().height(context, 1),
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, _) {
              return ShimmerLoading(
                  isLoading: true,
                  child: buildAllCarsSections(
                    car: null,
                    onTap: null,
                    context: context,
                  ));
            },
          ),
        );
      },
    );
  }
}
