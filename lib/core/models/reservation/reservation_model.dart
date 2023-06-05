class Reservation {
  String id;
  Customer customer;
  String renter;
  String car;
  DateTime startDate;
  DateTime returnDate;
  String reservationStatus;

  Reservation({
    required this.id,
    required this.customer,
    required this.renter,
    required this.car,
    required this.startDate,
    required this.returnDate,
    required this.reservationStatus,
  });

  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      customer: Customer.fromJSON(json['customer']),
      renter: json['renter'],
      car: json['car'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      reservationStatus: json['reservationStatus'],
    );
  }
}

class Customer {
  String id;
  String name;

  Customer({
    required this.id,
    required this.name,
  });

  factory Customer.fromJSON(Map<String, String> json) {
    return Customer(
      id: json['_id']!,
      name: json['name']!,
    );
  }
}
