import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

abstract class BackendAuthenticationRepository {
  /// create user params
  /// 1. avatar
  /// 2. user
  /// 3. name
  /// 4. phoneNumber
  /// 5. email
  /// 6. dob
  /// 7. residence

  Future<Either<String, BackendUserInfo>> createOrUpdateUser(
      Map<String, dynamic> params);

  /// delete user params
  /// 1. userId

  Future<Either<String, void>> deleteUserFromBackend(
      Map<String, dynamic> params);
}
