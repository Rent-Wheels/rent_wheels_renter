import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/firebase/firebase_auth_repository.dart';

class VerifyEmail extends UseCase<void, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  VerifyEmail({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.verifyEmail(params);
  }
}
