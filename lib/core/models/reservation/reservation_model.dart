import 'package:rent_wheels_renter/core/models/user/user_model.dart';

class Reservation {
  String id;
  BackendUser customer;
  String renter;
  String car;
  String destination;
  DateTime startDate;
  DateTime returnDate;
  String status;
  num price;

  Reservation({
    required this.id,
    required this.customer,
    required this.renter,
    required this.car,
    required this.destination,
    required this.startDate,
    required this.returnDate,
    required this.status,
    required this.price,
  });

  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      customer: BackendUser.fromJSON(json['customer']['id']),
      renter: json['renter'],
      car: json['car'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      status: json['status'],
      price: json['price'],
    );
  }
}
