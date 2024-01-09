import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels_renter/core/urls/endpoints.dart';
import 'package:rent_wheels_renter/core/urls/urls.dart';
import 'package:rent_wheels_renter/src/reservations/data/model/reservation_info_model.dart';

abstract class ReservationRemoteDatasource {
  Future<List<ReservationInfoModel>> getAllReservations(
    Map<String, dynamic> params,
  );

  Future<ReservationInfoModel> updateReservationStatus(
    Map<String, dynamic> params,
  );

  Future<List<ReservationInfoModel>> getCarRentalHistory(
    Map<String, dynamic> params,
  );
}

class ReservationRemoteDatasourceImpl implements ReservationRemoteDatasource {
  final Client client;
  final Urls urls;

  ReservationRemoteDatasourceImpl({required this.client, required this.urls});

  @override
  Future<List<ReservationInfoModel>> getAllReservations(
      Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getReservations,
      queryParameters: {
        'renterId': params['renterId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.get(uri, headers: headers);

    if (response.statusCode != 200) throw Exception(response.body);

    final results = jsonDecode(response.body);

    return results.map<ReservationInfoModel>(
      (car) => ReservationInfoModel.fromJSON(car),
    );
  }

  @override
  Future<List<ReservationInfoModel>> getCarRentalHistory(
      Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getCarHistory,
      urlParameters: {
        'carId': params['carId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.get(uri, headers: headers);

    if (response.statusCode != 200) throw Exception(response.body);

    final results = jsonDecode(response.body);

    return results.map<ReservationInfoModel>(
      (car) => ReservationInfoModel.fromJSON(car),
    );
  }

  @override
  Future<ReservationInfoModel> updateReservationStatus(
      Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.changeReservationStatus,
      queryParameters: {
        'reservationId': params['reservationId'],
      },
    );

    Map<String, String> headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['bearer']});

    final response = await client.patch(
      uri,
      headers: headers,
      body: jsonEncode(params['body']),
    );

    if (response.statusCode != 200) throw Exception(response.body);

    final results = jsonDecode(response.body);

    return ReservationInfoModel.fromJSON(results);
  }
}
