import 'dart:convert';
import 'package:http/http.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/core/urls/endpoints.dart';
import 'package:rent_wheels_renter/core/urls/urls.dart';
import 'package:rent_wheels_renter/src/cars/data/model/car_info_model.dart';

abstract class CarsRemoteDatasource {
  Future<List<CarInfoModel>> getAllCars(Map<String, dynamic> params);

  Future<CarInfoModel> addNewCar(Map<String, dynamic> params);

  Future<CarInfoModel> updateCarDetails(Map<String, dynamic> params);

  Future<CarInfoModel> changeCarAvailability(Map<String, dynamic> params);

  Future<Status> deleteCar(Map<String, dynamic> params);
}

class CarsRemoteDatasourceImpl implements CarsRemoteDatasource {
  final Urls urls;
  final Client client;

  CarsRemoteDatasourceImpl({required this.urls, required this.client});

  @override
  Future<CarInfoModel> addNewCar(Map<String, dynamic> params) async {
    final uri = urls.returnUri(endpoint: Endpoints.addCar);

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final body = jsonEncode(params['carDetails']);

    final response = await client.post(
      uri,
      body: body,
      headers: headers,
    );

    if (response.statusCode != 201) throw Exception(response.body);

    return CarInfoModel.fromJSON(jsonDecode(response.body));
  }

  @override
  Future<CarInfoModel> changeCarAvailability(
    Map<String, dynamic> params,
  ) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.changeAvailability,
      urlParameters: {
        'carId': params['carId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.patch(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) throw Exception(response.body);

    return CarInfoModel.fromJSON(jsonDecode(response.body));
  }

  @override
  Future<Status> deleteCar(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.updateOrDeleteCar,
      urlParameters: {
        'carId': params['carId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.delete(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) throw Exception(response.body);

    return Status.success;
  }

  @override
  Future<List<CarInfoModel>> getAllCars(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getRenterCars,
      urlParameters: {
        'renterId': params['renterId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.get(uri, headers: headers);

    if (response.statusCode != 200) throw Exception(response.body);

    final results = jsonDecode(response.body);

    return results.map<CarInfoModel>((car) => CarInfoModel.fromJSON(car));
  }

  @override
  Future<CarInfoModel> updateCarDetails(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.updateOrDeleteCar,
      urlParameters: {
        'carId': params['carId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final body = jsonEncode(params['carDetails']);

    final response = await client.post(
      uri,
      body: body,
      headers: headers,
    );

    if (response.statusCode != 200) throw Exception(response.body);

    return CarInfoModel.fromJSON(jsonDecode(response.body));
  }
}
