import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';

abstract class CarsRepository {
  Future<Either<String, List<CarInfo>>> getAllCars();

  Future<Either<String, CarInfo>> addNewCar({required CarInfo carDetails});

  Future<Either<String, CarInfo>> updateCarDetails({
    required CarInfo carDetails,
  });

  Future<Either<String, CarInfo>> changeCarAvailability({
    required String carId,
  });

  Future<Either<String, List<Reservation>>> getCarRentalHistory({
    required String carId,
  });

  Future<Either<String, Status>> deleteCar({
    required String carId,
    required String registrationNumber,
  });
}
