import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/reservation_details_widget.dart';

class ReservationDetails extends StatefulWidget {
  final Car car;
  final BackendUser customer;
  final Reservation reservation;

  const ReservationDetails({
    super.key,
    required this.car,
    required this.customer,
    required this.reservation,
  });

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  @override
  Widget build(BuildContext context) {
    Car car = widget.car;
    BackendUser customer = widget.customer;
    Reservation reservation = widget.reservation;

    Duration getDuration() {
      Duration duration =
          reservation.returnDate!.difference(reservation.startDate!);

      if (reservation.returnDate!.isAtSameMomentAs(reservation.startDate!)) {
        duration = const Duration(days: 1);
      }

      return duration;
    }

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context, reservation.status),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes().width(context, 0.04),
          right: Sizes().width(context, 0.04),
          bottom: Sizes().height(context, 0.1),
        ),
        child: buildReservationDetails(
          car: car,
          context: context,
          customer: customer,
          pageTitle: 'Reservation',
          duration: getDuration(),
          reservation: reservation,
        ),
      ),
      // bottomSheet: buildReservationDetailsBottomSheet(
      //         buttonTitle: 'Make Reservation',
      //         context: context,
      //         onPressed: () async {
      //           try {
      //             buildLoadingIndicator(context, 'Making Reservation');
      //             await RentWheelsReservationsMethods()
      //                 .makeReservation(reservationDetails: reservation);
      //             if (!mounted) return;
      //             Navigator.pop(context);
      //             Navigator.push(
      //               context,
      //               CupertinoPageRoute(
      //                 builder: (context) => const ReservationSuccessful(),
      //               ),
      //             );
      //           } catch (e) {
      //             if (!mounted) return;
      //             Navigator.pop(context);
      //             showErrorPopUp(e.toString(), context);
      //           }
      //         },
      //       ),
    );
  }
}
