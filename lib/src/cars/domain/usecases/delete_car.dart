import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';

class DeleteCar extends UseCase<Status, Map<String, dynamic>> {
  final CarsRepository repository;

  DeleteCar({required this.repository});

  @override
  Future<Either<String, Status>> call(Map<String, dynamic> params) async {
    return await repository.deleteCar(params);
  }
}
