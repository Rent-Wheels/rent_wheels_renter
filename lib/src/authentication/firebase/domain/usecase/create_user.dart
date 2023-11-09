import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/firebase/domain/repository/firebase_auth_repository.dart';

class CreateUserWithEmailAndPassword
    extends UseCase<UserCredential, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  CreateUserWithEmailAndPassword({required this.repository});
  @override
  Future<Either<String, UserCredential>> call(
      Map<String, dynamic> params) async {
    return await repository.createUserWithEmailAndPassword(params);
  }
}
