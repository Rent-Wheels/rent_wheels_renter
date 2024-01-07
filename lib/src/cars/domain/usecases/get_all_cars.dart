import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';

class GetAllCars extends UseCase<List<CarInfo>, NoParams> {
  final CarsRepository repository;

  GetAllCars({required this.repository});

  @override
  Future<Either<String, List<CarInfo>>> call(NoParams params) async {
    return await repository.getAllCars();
  }
}
