import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/backend/domain/repository/backend_authentication_repo.dart';

class DeleteUser extends UseCase<void, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  DeleteUser({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteUser(params);
  }
}
