import 'package:rent_wheels_renter/src/user/data/model/user_info_model.dart';

abstract class BackendAuthenticationLocalDatasource {
  Future cacheUserInfo(BackendUserInfoModel userInfo);
  Future<BackendUserInfoModel> getCachedUserInfo();
  Future deleteCachedUserInfo();
}
