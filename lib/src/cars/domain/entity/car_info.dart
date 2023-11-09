import 'package:equatable/equatable.dart';

class CarInfo extends Equatable {
  final String? carId,
      owner,
      make,
      model,
      yearOfManufacture,
      color,
      registrationNumber,
      condition,
      plan,
      type,
      location,
      description,
      terms,
      duration;
  final num? capacity, rate, maxDuration;
  final bool? availability;
  final List<Media>? media;

  const CarInfo({
    required this.carId,
    required this.owner,
    required this.make,
    required this.model,
    required this.capacity,
    required this.color,
    required this.yearOfManufacture,
    required this.registrationNumber,
    required this.condition,
    required this.rate,
    required this.plan,
    required this.type,
    required this.availability,
    required this.location,
    required this.maxDuration,
    required this.description,
    required this.terms,
    required this.duration,
    required this.media,
  });

  @override
  List<Object?> get props => [
        carId,
        owner,
        make,
        model,
        capacity,
        color,
        yearOfManufacture,
        registrationNumber,
        condition,
        rate,
        plan,
        type,
        availability,
        location,
        maxDuration,
        description,
        terms,
        duration,
        media,
      ];
}

class Media extends Equatable {
  final String? mediaURL;

  const Media({required this.mediaURL});

  @override
  List<Object?> get props => [mediaURL];
}
