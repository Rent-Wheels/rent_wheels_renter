import 'package:rent_wheels_renter/core/models/car/car_model.dart';

abstract class RentWheelsCarEndpoints {
  Future<Car> addNewCar({required Car carDetails});
  Future<List<Car>> getAllCars();
  Future<Car> updateCarDetails({required Car carDetails});
}
