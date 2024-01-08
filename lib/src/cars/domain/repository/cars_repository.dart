import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';

abstract class CarsRepository {
  ///params
  ///1. renter id
  Future<Either<String, List<CarInfo>>> getAllCars(Map<String, dynamic> params);

  /// addNewCar params
  /// 1. car details
  Future<Either<String, CarInfo>> addNewCar(Map<String, dynamic> params);

  /// updateCarDetails params
  /// 1. car details
  Future<Either<String, CarInfo>> updateCarDetails(Map<String, dynamic> params);

  Future<Either<String, CarInfo>> changeCarAvailability(
      Map<String, dynamic> params);

  // Future<Either<String, List<Reservation>>> getCarRentalHistory(
  //     Map<String, dynamic> params);

  Future<Either<String, Status>> deleteCar(Map<String, dynamic> params);
}
