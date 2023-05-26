import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:http_parser/http_parser.dart';

import 'package:rent_wheels_renter/core/models/car/car_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/cars/endpoints/car_endpoints.dart';

class RentWheelsCarMethods implements RentWheelsCarEndpoints {
  @override
  Future<Car> addNewCar({required Car carDetails}) async {
    const uuid = Uuid();
    final request =
        MultipartRequest('POST', Uri.parse('${global.baseURL}/cars/'));

    request.headers.addAll(global.headers);
    request.fields['owner'] = carDetails.owner;
    request.fields['make'] = carDetails.make;
    request.fields['model'] = carDetails.model;
    request.fields['capacity'] = carDetails.capacity.toString();
    request.fields['yearOfManufacture'] = carDetails.yearOfManufacture;
    request.fields['registrationNumber'] = carDetails.registrationNumber;
    request.fields['condition'] = carDetails.condition;
    request.fields['rate'] = carDetails.rate.toString();
    request.fields['plan'] = carDetails.plan;
    request.fields['type'] = carDetails.type;
    request.fields['availability'] = carDetails.availability ? '1' : '0';
    request.fields['location'] = carDetails.location;
    request.fields['maxDuration'] = carDetails.maxDuration.toString();
    request.fields['description'] = carDetails.description;
    request.fields['terms'] = carDetails.terms;

    request.files.addAll(carDetails.media.map(
      (media) {
        final ext = media.mediaURL.split('.').last;
        return MultipartFile(
          'media',
          File(media.mediaURL).readAsBytes().asStream(),
          File(media.mediaURL).lengthSync(),
          filename: '${uuid.v1()}.$ext',
          contentType: MediaType.parse(lookupMimeType(media.mediaURL)!),
        );
      },
    ).toList());

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return Car.fromJSON(jsonDecode(responseBody));
    }
    throw Exception();
  }

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
}
