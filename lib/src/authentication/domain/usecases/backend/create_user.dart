import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/backend/backend_authentication_repo.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

class CreateOrUpdateUser
    extends UseCase<BackendUserInfo, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  CreateOrUpdateUser({required this.repository});
  @override
  Future<Either<String, BackendUserInfo>> call(
      Map<String, dynamic> params) async {
    return await repository.createOrUpdateUser(params);
  }
}
