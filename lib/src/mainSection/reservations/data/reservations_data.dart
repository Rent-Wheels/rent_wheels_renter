import 'package:flutter/cupertino.dart';

import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/presentation/reservation_details.dart';
import 'package:rent_wheels_renter/src/mainSection/reservations/widgets/reservation_information_sections_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';
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
          if (reservations.isNotEmpty) {
            reservations.sort(
              (a, b) => b.createdAt!.compareTo(a.createdAt!),
            );
          }

          Map<String, List<Reservation>> getReservations() {
            Map<String, List<Reservation>> reservationCategories = {};

            for (var reservation in reservations) {
              String status = reservation.status!;
              if (reservationCategories.containsKey(status)) {
                reservationCategories[status]!.add(reservation);
              } else {
                reservationCategories.addEntries({
                  reservation.status!: [reservation]
                }.entries);
              }
            }

            return reservationCategories;
          }

          final Map<String, List<Reservation>> sections = getReservations();

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
              reservations.isEmpty
                  ? buildErrorMessage(
                      label: 'You have no reservations!',
                      context: context,
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: sections.values
                              .elementAt(currentIndex)
                              .map((reservation) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: Sizes().height(context, 0.04),
                                    ),
                                    child: buildReservationSections(
                                      isLoading: false,
                                      context: context,
                                      car: reservation.car!,
                                      reservation: reservation,
                                      onAccept: () async {
                                        try {
                                          buildLoadingIndicator(context, '');
                                          await RentWheelsReservationsMethods()
                                              .updateReservationStatus(
                                            reservationId: reservation.id!,
                                            status: 'Accepted',
                                          );

                                          if (!mounted) return;
                                          Navigator.pop(context);
                                          showSuccessPopUp(
                                            'Reservation Accepted!',
                                            context,
                                          );
                                        } catch (e) {
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                          showErrorPopUp(e.toString(), context);
                                        }
                                      },
                                      onDecline: () => buildConfirmationDialog(
                                        context: context,
                                        label: 'Decline Reservation',
                                        buttonName: 'Decline Reservation',
                                        message:
                                            'Are you sure you want to decline this reservation?',
                                        onAccept: () async {
                                          try {
                                            Navigator.pop(context);
                                            buildLoadingIndicator(context, '');
                                            await RentWheelsReservationsMethods()
                                                .updateReservationStatus(
                                              reservationId: reservation.id!,
                                              status: 'Declined',
                                            );

                                            if (!mounted) return;
                                            Navigator.pop(context);
                                            showSuccessPopUp(
                                              'Reservation Declined!',
                                              context,
                                            );
                                          } catch (e) {
                                            if (!mounted) return;
                                            Navigator.pop(context);
                                            showErrorPopUp(
                                                e.toString(), context);
                                          }
                                        },
                                      ),
                                      onPressed: () async {
                                        final status = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ReservationDetails(
                                              car: reservation.car!,
                                              customer: reservation.customer,
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
                              .toList(),
                        ),
                      ),
                    ),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes().height(context, 0.05),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ShimmerLoading(
                    isLoading: true,
                    child: buildFilterButtons(
                      width: Sizes().width(context, 0.2),
                      label: '',
                      context: context,
                      onTap: null,
                    ),
                  );
                },
              ),
            ),
            Space().height(context, 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ShimmerLoading(
                    isLoading: true,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: Sizes().height(context, 0.04),
                      ),
                      child: buildReservationSections(
                        onAccept: null,
                        onDecline: null,
                        onPressed: null,
                        isLoading: true,
                        context: context,
                        reservation: Reservation(),
                        car: Car(media: [Media(mediaURL: '')]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
