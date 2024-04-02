import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/backend/backend_authentication_repo.dart';

class DeleteUserFromBackend extends UseCase<void, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  DeleteUserFromBackend({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteUserFromBackend(params);
  }
}
