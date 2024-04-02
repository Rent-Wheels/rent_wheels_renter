import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';

class BackendUserInfo extends Equatable {
  final String? id,
      userId,
      name,
      email,
      dob,
      phoneNumber,
      profilePicture,
      placeOfResidence;
  final num? role;
  final List<CarInfo>? cars;

  const BackendUserInfo({
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'email': email,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'placeOfResidence': placeOfResidence,
        'role': role,
        'cars': cars?.map((e) => e.toJson()).toList()
      };
}
