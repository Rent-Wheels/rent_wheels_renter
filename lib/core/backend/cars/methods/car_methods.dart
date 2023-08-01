import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/files/file_methods.dart';
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/backend/cars/endpoints/car_endpoints.dart';

class RentWheelsCarMethods implements RentWheelsCarEndpoints {
  @override
  Future<List<Car>> getAllCars() async {
    final response = await get(
      Uri.parse('${global.baseURL}/renters/${global.userDetails!.id}/cars'),
      headers: global.headers,
    );
    if (response.statusCode == 200) {
      List results = jsonDecode(response.body);
      return List<Car>.from(results.map((car) => Car.fromJSON(car)));
    }
    throw Exception();
  }

  @override
  Future<List<Reservation>> getCarRentalHistory({required String carId}) async {
    final response = await get(
      Uri.parse('${global.baseURL}/cars/$carId/history'),
      headers: global.headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> results = jsonDecode(response.body);
      List reservations = results['rentalHistory'];
      return reservations.isEmpty
          ? []
          : List<Reservation>.from(reservations
              .map((reservation) => Reservation.fromJSON(reservation)));
    }
    throw Exception();
  }

  @override
  Future<Car> addNewCar({required Car carDetails}) async {
    global.headers.addEntries({
      'content-type': 'application/json',
      'accept': 'application/json'
    }.entries);

    try {
      List<Map<String, String>> media = [];

      for (var carMedia in carDetails.media!) {
        final ext = carMedia.mediaURL!.split('.').last;
        final mediaURL = await RentWheelsFilesMethods().getFileUrl(
          file: File(carMedia.mediaURL!),
          filePath:
              'users/${global.user!.uid}/cars/${carDetails.registrationNumber!}/car_media_${carDetails.media!.indexOf(carMedia)}.$ext',
        );
        media.add({'mediaURL': mediaURL});
      }

      final response = await post(Uri.parse('${global.baseURL}/cars/'),
          headers: global.headers,
          body: jsonEncode(
            {
              'owner': global.userDetails!.id,
              'make': carDetails.make!,
              'model': carDetails.model!,
              'capacity': carDetails.capacity,
              'yearOfManufacture': carDetails.yearOfManufacture!,
              'registrationNumber': carDetails.registrationNumber!,
              'condition': carDetails.condition!,
              'rate': carDetails.rate,
              'plan': carDetails.plan!,
              'type': carDetails.type!,
              'location': carDetails.location!,
              'maxDuration': carDetails.maxDuration,
              'description': carDetails.description!,
              'terms': carDetails.terms!,
              'color': carDetails.color!,
              'durationUnit': carDetails.duration!,
              'media': media
            },
          ));

      if (response.statusCode == 201) {
        return Car.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Car> updateCarDetails({required Car carDetails}) async {
    global.headers.addEntries({
      'content-type': 'application/json',
      'accept': 'application/json'
    }.entries);

    try {
      List<Map<String, String>> media = [];

      for (var carMedia in carDetails.media!) {
        if (!isURL(carMedia.mediaURL!)) {
          final ext = carMedia.mediaURL!.split('.').last;
          final mediaURL = await RentWheelsFilesMethods().getFileUrl(
            file: File(carMedia.mediaURL!),
            filePath:
                'users/${global.user!.uid}/cars/${carDetails.registrationNumber!}/car_media_${carDetails.media!.indexOf(carMedia)}.$ext',
          );
          media.add({'mediaURL': mediaURL});
        } else {
          media.add({'mediaURL': carMedia.mediaURL!});
        }
      }

      final response =
          await put(Uri.parse('${global.baseURL}/cars/${carDetails.carId}'),
              headers: global.headers,
              body: jsonEncode(
                {
                  'owner': global.userDetails!.id,
                  'make': carDetails.make!,
                  'model': carDetails.model!,
                  'capacity': carDetails.capacity,
                  'yearOfManufacture': carDetails.yearOfManufacture!,
                  'registrationNumber': carDetails.registrationNumber!,
                  'condition': carDetails.condition!,
                  'rate': carDetails.rate,
                  'plan': carDetails.plan!,
                  'type': carDetails.type!,
                  'location': carDetails.location!,
                  'maxDuration': carDetails.maxDuration,
                  'description': carDetails.description!,
                  'terms': carDetails.terms!,
                  'color': carDetails.color!,
                  'durationUnit': carDetails.duration!,
                  'media': media
                },
              ));

      if (response.statusCode == 200) {
        return Car.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Car> changeCarAvailability({required String carId}) async {
    final response = await patch(
        Uri.parse('${global.baseURL}/cars/$carId/availability'),
        headers: global.headers);

    if (response.statusCode == 200) {
      return Car.fromJSON(jsonDecode(response.body));
    }

    throw Exception();
  }

  @override
  Future deleteCar({required String carId}) async {
    final response = await delete(Uri.parse('${global.baseURL}/cars/$carId'),
        headers: global.headers);

    if (response.statusCode == 200) return Status.success;

    return Status.failed;
  }
}
