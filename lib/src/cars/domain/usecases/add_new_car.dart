import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';

class AddNewCar extends UseCase<CarInfo, CarInfo> {
  final CarsRepository repository;

  AddNewCar({required this.repository});

  @override
  Future<Either<String, CarInfo>> call(CarInfo params) async {
    return await repository.addNewCar(carDetails: params);
  }
}
