import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';

class Reservation {
  String? id;
  dynamic customer;
  String? renter;
  Car? car;
  String? destination;
  DateTime? startDate;
  DateTime? returnDate;
  String? status;
  num? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Reservation({
    this.id,
    this.customer,
    this.renter,
    this.car,
    this.destination,
    this.startDate,
    this.returnDate,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.price,
  });

  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      customer: json['customer']['id'] != null
          ? json['customer']['id'] is String
              ? json['customer']['id']
              : BackendUser.fromJSON(json['customer']['id'])
          : null,
      renter: json['renter'] is String ? json['renter'] : null,
      car: json['car'] is String ? null : Car.fromJSON(json['car']),
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
      price: json['price'],
    );
  }
}
