import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/firebase/domain/repository/firebase_auth_repository.dart';

class ResetPassword extends UseCase<void, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  ResetPassword({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.resetPassword(params);
  }
}