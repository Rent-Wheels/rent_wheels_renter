import 'package:flutter/cupertino.dart';

import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/presentation/reservation_details.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/reservation_information_sections_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/backend/reservations/methods/reservations_methods.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class ReservationsData extends StatefulWidget {
  const ReservationsData({super.key});

  @override
  State<ReservationsData> createState() => _ReservationsDataState();
}

class _ReservationsDataState extends State<ReservationsData> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RentWheelsReservationsMethods().getAllReservations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Reservation> reservations = snapshot.data!;

          List<Reservation> pendingReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'pending')
                .toList();
          }

          List<Reservation> acceptedReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'accepted')
                .toList();
          }

          List<Reservation> ongoingReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'ongoing')
                .toList();
          }

          List<Reservation> completedReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'completed')
                .toList();
          }

          List<Reservation> cancelledReservations() {
            return reservations
                .where((reservation) =>
                    reservation.status!.toLowerCase() == 'cancelled')
                .toList();
          }

          final Map<String, List<Reservation>> sections = {
            'All': reservations,
            'Pending': pendingReservations(),
            'Accepted': acceptedReservations(),
            'Ongoing': ongoingReservations(),
            'Completed': completedReservations(),
            'Cancelled': cancelledReservations(),
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes().height(context, 0.05),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      btnColor: currentIndex == index
                          ? rentWheelsBrandDark900
                          : rentWheelsNeutralLight0,
                      style: currentIndex == index
                          ? heading6Neutral0
                          : heading6Brand,
                      label: sections.keys.toList()[index],
                      context: context,
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              ...sections.values
                  .elementAt(currentIndex)
                  .map((reservation) => Padding(
                        padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.04),
                        ),
                        child: buildReservationSections(
                          isLoading: false,
                          context: context,
                          car: reservation.car,
                          reservation: reservation,
                          onPressed: () async {
                            final status = await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ReservationDetails(
                                  car: reservation.car,
                                  customer: reservation.customer!,
                                  reservation: reservation,
                                ),
                              ),
                            );

                            if (status != null) {
                              setState(() {
                                reservation.status = status;
                              });
                            }
                          },
                        ),
                      ))
                  .toList()
            ],
          );
        }
        if (snapshot.hasError) {
          return buildErrorMessage(
            label: 'An error occured',
            errorMessage: snapshot.error.toString(),
            context: context,
          );
        }

        return ShimmerLoading(
          isLoading: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes().height(context, 0.05),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return buildFilterButtons(
                      width: Sizes().width(context, 0.2),
                      label: '',
                      context: context,
                      onTap: null,
                    );
                  },
                ),
              ),
              Space().height(context, 0.02),
              SizedBox(
                height: Sizes().height(context, 0.9),
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: Sizes().height(context, 0.04)),
                      child: buildReservationSections(
                        isLoading: true,
                        context: context,
                        onPressed: null,
                        reservation: Reservation(),
                        car: Car(media: [Media(mediaURL: '')]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
