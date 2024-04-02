import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/network/network_info.dart';
import 'package:rent_wheels_renter/src/reservations/data/datasource/remoteds.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/reservation_info.dart';
import 'package:rent_wheels_renter/src/reservations/domain/repository/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final NetworkInfo networkInfo;
  final ReservationRemoteDatasource remoteDatasource;

  ReservationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });
  @override
  Future<Either<String, List<ReservationInfo>>> getAllReservations(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.getAllReservations(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ReservationInfo>>> getCarRentalHistory(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.getCarRentalHistory(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ReservationInfo>> updateReservationStatus(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.updateReservationStatus(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
