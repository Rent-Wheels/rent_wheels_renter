import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';

abstract class RentWheelsCarEndpoints {
  Future<List<Car>> getAllCars();
  Future<Car> addNewCar({required Car carDetails});
  Future<Car> updateCarDetails({required Car carDetails});
  Future<Car> changeCarAvailability({required String carId});
  Future<List<Reservation>> getCarRentalHistory({required String carId});
  Future deleteCar({required String carId, required String registrationNumber});
}
