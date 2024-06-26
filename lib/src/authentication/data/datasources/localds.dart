import 'dart:convert';

import 'package:rent_wheels_renter/src/authentication/data/datasources/backend/localds.dart';
import 'package:rent_wheels_renter/src/user/data/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationLocalDatasource
    implements BackendAuthenticationLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'USER_CACHE_KEY';

  AuthenticationLocalDatasource({required this.sharedPreferences});

  @override
  Future cacheUserInfo(BackendUserInfoModel userInfo) {
    final cacheData = jsonEncode(userInfo.toJson());
    return sharedPreferences.setString(cacheKey, cacheData);
  }

  @override
  Future deleteCachedUserInfo() {
    return sharedPreferences.remove(cacheKey);
  }

  @override
  Future<BackendUserInfoModel> getCachedUserInfo() async {
    final cacheData = sharedPreferences.getString(cacheKey);

    if (cacheData == null) {
      throw Exception('Cache error');
    }

    return BackendUserInfoModel.fromJSON(json.decode(cacheData));
  }
}
