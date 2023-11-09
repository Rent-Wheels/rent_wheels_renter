import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';

class UserInfo extends Equatable {
  final String? id,
      userId,
      name,
      email,
      dob,
      phoneNumber,
      profilePicture,
      placeOfResidence;
  final num? role;
  final List<Car>? cars;

  const UserInfo({
    this.cars,
    this.id,
    this.userId,
    this.name,
    this.email,
    this.dob,
    this.phoneNumber,
    this.role,
    this.profilePicture,
    this.placeOfResidence,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        email,
        dob,
        phoneNumber,
        role,
        profilePicture,
        placeOfResidence,
        cars
      ];
}
