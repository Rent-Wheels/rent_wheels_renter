import 'package:rent_wheels_renter/core/models/user/user_model.dart';

abstract class RentWheelsUserEndpoints {
  Future<BackendUser> getUserDetails({required String userId});
  Future<BackendUser> upgradeToRenter({required String userId});
}
