import 'package:rent_wheels_renter/src/cars/data/model/car_info_model.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/customer.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/reservation_info.dart';
import 'package:rent_wheels_renter/src/user/data/model/user_info_model.dart';

class ReservationInfoModel extends ReservationInfo {
  const ReservationInfoModel({
    required super.id,
    required super.customer,
    required super.renter,
    required super.car,
    required super.destination,
    required super.startDate,
    required super.returnDate,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    required super.price,
  });

  factory ReservationInfoModel.fromJSON(Map<String, dynamic> json) {
    return ReservationInfoModel(
      id: json['id'],
      destination: json['destination'],
      startDate: json['startDate'],
      returnDate: json['returnDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      price: json['price'],
      car: CarInfoModel.fromJSON(json['car']),
      customer: CustomerModel.fromJSON(json['customer']),
      renter: BackendUserInfoModel.fromJSON(json['renter']),
    );
  }
}

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
  });

  factory CustomerModel.fromJSON(Map<String, dynamic>? json) {
    return CustomerModel(
      id: json?['id'],
      name: json?['name'],
    );
  }
}
