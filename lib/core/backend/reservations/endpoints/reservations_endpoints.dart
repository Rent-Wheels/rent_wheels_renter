import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';

abstract class RentWheelsReservationsEndpoint {
  Stream<List<Reservation>> getAllReservations();
  Future<Reservation> updateReservationStatus(
      {required String reservationId, required String status});
}
