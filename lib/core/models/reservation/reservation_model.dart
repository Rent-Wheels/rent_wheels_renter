import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';

class Reservation {
  String? id;
  BackendUser? customer;
  String? renter;
  dynamic car;
  String? destination;
  DateTime? startDate;
  DateTime? returnDate;
  String? status;
  num? price;

  Reservation({
    this.id,
    this.customer,
    this.renter,
    this.car,
    this.destination,
    this.startDate,
    this.returnDate,
    this.status,
    this.price,
  });

  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      customer: BackendUser.fromJSON(json['customer']['id']),
      renter: json['renter'],
      car: json['car'] is String ? json['car'] : Car.fromJSON(json['car']),
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      status: json['status'],
      price: json['price'],
    );
  }
}
