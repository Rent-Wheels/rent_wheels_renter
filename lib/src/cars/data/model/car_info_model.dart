import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';

class CarInfoModel extends CarInfo {
  const CarInfoModel({
    required super.carId,
    required super.owner,
    required super.make,
    required super.model,
    required super.capacity,
    required super.color,
    required super.yearOfManufacture,
    required super.registrationNumber,
    required super.condition,
    required super.rate,
    required super.plan,
    required super.type,
    required super.availability,
    required super.location,
    required super.maxDuration,
    required super.description,
    required super.terms,
    required super.duration,
    required super.media,
  });

  factory CarInfoModel.fromJSON(Map<String, dynamic> json) {
    return CarInfoModel(
      carId: json['_id'],
      owner: json['owner'],
      make: json['make'],
      model: json['model'],
      capacity: json['capacity'],
      yearOfManufacture: json['yearOfManufacture'],
      color: json['color'],
      registrationNumber: json['registrationNumber'],
      condition: json['condition'],
      rate: json['rate'],
      plan: json['plan'],
      type: json['type'],
      availability: json['availability'],
      location: json['location'],
      maxDuration: json['maxDuration'],
      duration: json['durationUnit'],
      description: json['description'],
      terms: json['terms'],
      media: json['media']
          .map<Media>((media) => MediaModel.fromJSON(media))
          .toList(),
    );
  }
}

class MediaModel extends Media {
  const MediaModel({required super.mediaURL});

  factory MediaModel.fromJSON(Map<String, dynamic> json) {
    return MediaModel(mediaURL: json['mediaURL']);
  }
}
