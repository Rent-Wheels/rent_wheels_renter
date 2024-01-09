import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/reservation_info.dart';
import 'package:rent_wheels_renter/src/reservations/domain/repository/reservation_repository.dart';

class GetAllReservations
    extends UseCase<List<ReservationInfo>, Map<String, dynamic>> {
  final ReservationRepository repository;

  GetAllReservations({required this.repository});

  @override
  Future<Either<String, List<ReservationInfo>>> call(
      Map<String, dynamic> params) async {
    return await repository.getAllReservations(params);
  }
}
