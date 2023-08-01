import 'package:rent_wheels_renter/core/models/user/user_model.dart';

class Reservation {
  String id;
  BackendUser customer;
  String renter;
  String car;
  DateTime startDate;
  DateTime returnDate;
  String status;

  Reservation({
    required this.id,
    required this.customer,
    required this.renter,
    required this.car,
    required this.startDate,
    required this.returnDate,
    required this.status,
  });

  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      customer: BackendUser.fromJSON(json['customer']['id']),
      renter: json['renter'],
      car: json['car'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      status: json['status'],
    );
  }
}
