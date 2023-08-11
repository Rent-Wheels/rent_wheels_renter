import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/dashboard/dashboard_data_model.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/src/mainSection/home/widgets/most_profitable_car_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/home/widgets/top_statistics_widget.dart';

class DashboardData extends StatefulWidget {
  const DashboardData({super.key});

  @override
  State<DashboardData> createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: RentWheelsReservationsMethods().getAllReservations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Reservation> reservations = snapshot.data!;

            if (reservations.isEmpty) {
              return Center(
                child: buildErrorMessage(
                    label: 'You have no reservations yet', context: context),
              );
            }

            List<Reservation> paidReservations = reservations
                .where((reservation) =>
                    (reservation.status == 'Paid' ||
                        reservation.status == 'Completed' ||
                        reservation.status == 'Ongoing') &&
                    reservation.createdAt!.isBefore(DateTime.now()))
                .toList();

            List getMostProfitableCars() {
              Map<String, num> profitableCars = {};

              for (var reservation in paidReservations) {
                String registrationNumber =
                    reservation.car!.registrationNumber!;
                if (profitableCars.containsKey(registrationNumber)) {
                  profitableCars[registrationNumber] =
                      profitableCars[registrationNumber]! + reservation.price!;
                } else {
                  profitableCars.addEntries(
                      {registrationNumber: reservation.price!}.entries);
                }
              }

              List topProfitableCars = profitableCars.entries.toList();

              topProfitableCars
                  .sort((car1, car2) => car2.value.compareTo(car1.value));

              return topProfitableCars.take(5).toList();
            }

            List<DashboardDataPoints> getMostProfitableCarsDashboardData() {
              String mostProfitableCar = getMostProfitableCars()[0].key;

              List<Reservation> profitableCarReservations = paidReservations
                  .where((reservation) =>
                      reservation.car!.registrationNumber == mostProfitableCar)
                  .toList();

              return profitableCarReservations
                  .map(
                    (reservation) => DashboardDataPoints(
                      points: reservation.price!,
                      days: reservation.createdAt!,
                    ),
                  )
                  .toList();
            }

            List getMostReservedCars() {
              Map<String, num> reservedCars = {};

              for (var reservation in paidReservations) {
                String registrationNumber =
                    reservation.car!.registrationNumber!;
                if (reservedCars.containsKey(registrationNumber)) {
                  reservedCars[registrationNumber] =
                      reservedCars[registrationNumber]! + 1;
                } else {
                  reservedCars.addEntries({registrationNumber: 1}.entries);
                }
              }

              List topReservedCars = reservedCars.entries.toList();

              topReservedCars.sort(
                (car1, car2) => car2.value.compareTo(car1.value),
              );

              return topReservedCars.take(5).toList();
            }

            List<DashboardDataPoints> getMostReservedCarsDashboardData() {
              String mostReservedCar = getMostReservedCars()[0].key;

              List<Reservation> reservedCarReservations = paidReservations
                  .where((reservation) =>
                      reservation.car!.registrationNumber == mostReservedCar)
                  .toList();

              return reservedCarReservations
                  .map(
                    (reservation) => DashboardDataPoints(
                      points: reservation.price!,
                      days: reservation.createdAt!,
                    ),
                  )
                  .toList();
            }

            Car getCarByRegistration(String registrationNumber) {
              return reservations
                  .firstWhere((reservation) =>
                      reservation.car!.registrationNumber == registrationNumber)
                  .car!;
            }

            List topStatistics = [
              buildTopStatistics(
                context: context,
                label: 'Most Profitable Car',
                price: getMostProfitableCars()[0].value,
                car: getCarByRegistration(getMostProfitableCars()[0].key),
              ),
              buildTopStatistics(
                context: context,
                label: 'Most Reserved Car',
                noOfReservations: getMostReservedCars()[0].value,
                car: getCarByRegistration(getMostReservedCars()[0].key),
              ),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Sizes().height(context, 0.4),
                  child: ListView.builder(
                      itemCount: topStatistics.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return topStatistics[index];
                      }),
                ),
                const Text(
                  'Top 5 Profitable Cars',
                  style: heading4Brand,
                ),
                Space().height(context, 0.02),
                ...getMostProfitableCars()
                    .map((e) => buildMostProfitableCar(
                          context: context,
                          price: e.value,
                          car: getCarByRegistration(e.key),
                        ))
                    .toList(),
                Space().height(context, 0.02),
                const Text(
                  'Top 5 Reserved Cars',
                  style: heading4Brand,
                ),
                Space().height(context, 0.02),
                ...getMostReservedCars()
                    .map((e) => buildMostProfitableCar(
                          context: context,
                          noOfReservations: e.value,
                          car: getCarByRegistration(e.key),
                        ))
                    .toList()
              ],
            );
          }

          return const Center();
        });
  }
}
