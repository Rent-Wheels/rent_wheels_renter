import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/customer.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

class ReservationInfo extends Equatable {
  final String? id,
      destination,
      startDate,
      returnDate,
      status,
      createdAt,
      updatedAt;
  final Customer customer;
  final CarInfo? car;
  final num? price;
  final BackendUserInfo renter;

  const ReservationInfo({
    required this.id,
    required this.customer,
    required this.renter,
    required this.car,
    required this.destination,
    required this.startDate,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        customer,
        renter,
        car,
        destination,
        startDate,
        returnDate,
        createdAt,
        updatedAt,
        status,
        price,
      ];
}
