import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels_renter/core/models/user/user_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/users/endpoints/user_endpoints.dart';

class RentWheelsUserMethods implements RentWheelsUserEndpoints {
  @override
  Future<BackendUser> getUserDetails({required String userId}) async {
    final response = await get(
      Uri.parse('${global.baseURL}/renters/$userId'),
      headers: global.headers,
    );

    if (response.statusCode == 200) {
      return BackendUser.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<BackendUser> upgradeToRenter({required String userId}) async {
    final response = await patch(
      Uri.parse('${global.baseURL}/users/$userId/upgrade'),
      headers: global.headers,
    );

    if (response.statusCode == 200) {
      return BackendUser.fromJSON(jsonDecode(response.body));
    }

    throw Exception(response.body);
  }
}
