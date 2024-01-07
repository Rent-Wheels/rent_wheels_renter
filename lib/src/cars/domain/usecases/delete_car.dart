import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';

class DeleteCar {
  final CarsRepository repository;

  DeleteCar({required this.repository});

  Future<Either<String, Status>> call({
    required String carId,
    required String registrationNumber,
  }) async {
    return await repository.deleteCar(
      carId: carId,
      registrationNumber: registrationNumber,
    );
  }
}
