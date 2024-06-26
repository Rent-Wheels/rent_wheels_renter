import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/firebase/firebase_auth_repository.dart';

class ReauthenticateUser extends UseCase<UserCredential, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  ReauthenticateUser({required this.repository});
  @override
  Future<Either<String, UserCredential>> call(
      Map<String, dynamic> params) async {
    return await repository.reauthenticateUser(params);
  }
}
