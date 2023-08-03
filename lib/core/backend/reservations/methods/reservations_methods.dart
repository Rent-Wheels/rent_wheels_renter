import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/models/reservation/reservation_model.dart';
import 'package:rent_wheels_renter/core/backend/reservations/endpoints/reservations_endpoints.dart';

class RentWheelsReservationsMethods extends RentWheelsReservationsEndpoint {
  @override
  Stream<List<Reservation>> getAllReservations() async* {
    yield* Stream.periodic(const Duration(milliseconds: 30), (_) {
      return get(
              Uri.parse(
                  '${global.baseURL}/reservations/?renterId=${global.userDetails!.id}'),
              headers: global.headers)
          .then((response) {
        if (response.statusCode == 200) {
          List results = jsonDecode(response.body);
          return List<Reservation>.from(
            results.map(
              (result) => Reservation.fromJSON(result),
            ),
          );
        } else {
          throw Exception(response.body);
        }
      });
    }).asyncMap((event) async => await event);
  }

  @override
  Future<Reservation> updateReservationStatus({
    required String reservationId,
    required String status,
  }) async {
    global.headers.addEntries({
      'content-type': 'application/json',
      'accept': 'application/json'
    }.entries);

    try {
      final body = {'status': status};
      final response = await patch(
        Uri.parse('${global.baseURL}/reservations/$reservationId/status'),
        headers: global.headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return Reservation.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
