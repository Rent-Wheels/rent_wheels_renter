import 'package:flutter/cupertino.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/presentation/add_car.dart';

import 'package:rent_wheels_renter/src/mainSection/cars/presentation/car_details.dart';
import 'package:rent_wheels_renter/src/mainSection/cars/widgets/all_cars_sections_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/backend/cars/methods/car_methods.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AllCarsData extends StatefulWidget {
  const AllCarsData({super.key});

  @override
  State<AllCarsData> createState() => _AllCarsDataState();
}

class _AllCarsDataState extends State<AllCarsData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RentWheelsCarMethods().getAllCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Car> cars = snapshot.data!;

          return cars.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildErrorMessage(
                      label: 'You have no cars added!',
                      context: context,
                    ),
                    buildGenericButtonWidget(
                      width: Sizes().width(context, 0.85),
                      isActive: true,
                      buttonName: 'Add Car',
                      context: context,
                      onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              const AddCar(type: CarReviewType.add),
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cars
                        .map(
                          (car) => buildAllCarsSections(
                            car: car,
                            context: context,
                            onTap: () async {
                              try {
                                buildLoadingIndicator(context, '');
                                final reservations =
                                    await RentWheelsCarMethods()
                                        .getCarRentalHistory(carId: car.carId!);

                                if (!mounted) return;
                                Navigator.pop(context);
                                final carId = await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => CarDetails(
                                      car: car,
                                      reservations: reservations,
                                    ),
                                  ),
                                );

                                if (carId != null) {
                                  setState(() {
                                    cars.removeWhere(
                                      (car) => car.carId == carId,
                                    );
                                  });
                                }
                              } catch (e) {
                                if (!mounted) return;
                                Navigator.pop(context);
                                showErrorPopUp(e.toString(), context);
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
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
