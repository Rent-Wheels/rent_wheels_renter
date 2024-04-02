import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/reservation_info.dart';

abstract class ReservationRepository {
  Future<Either<String, List<ReservationInfo>>> getAllReservations(
    Map<String, dynamic> params,
  );

  ///params
  ///1. reservationId
  ///2. status
  Future<Either<String, ReservationInfo>> updateReservationStatus(
    Map<String, dynamic> params,
  );

  ///params
  ///1. carId
  Future<Either<String, List<ReservationInfo>>> getCarRentalHistory(
    Map<String, dynamic> params,
  );
}
