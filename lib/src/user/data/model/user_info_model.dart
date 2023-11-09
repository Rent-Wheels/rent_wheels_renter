import 'package:rent_wheels_renter/src/cars/data/model/car_info_model.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

class UserInfoModel extends UserInfo {
  const UserInfoModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.dob,
    required super.phoneNumber,
    required super.role,
    required super.profilePicture,
    required super.placeOfResidence,
    required super.cars,
  });

  factory UserInfoModel.fromJSON(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
      cars: json['cars']
          .map<CarInfoModel>((car) => CarInfoModel.fromJSON(car))
          .toList(),
    );
  }
}
