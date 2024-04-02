import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';

class GetAllCars extends UseCase<List<CarInfo>, Map<String, dynamic>> {
  final CarsRepository repository;

  GetAllCars({required this.repository});

  @override
  Future<Either<String, List<CarInfo>>> call(
      Map<String, dynamic> params) async {
    return await repository.getAllCars(params);
  }
}
