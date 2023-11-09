import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/src/authentication/firebase/domain/repository/firebase_auth_repository.dart';

class FirebaseAuthenticationRepositoryImpl
    implements FirebaseAuthenticationRepository {
  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> deleteUser(Map<String, dynamic> params) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<String, UserCredential>> reauthenticateUser(
      Map<String, dynamic> params) {
    // TODO: implement reauthenticateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> resetPassword(Map<String, dynamic> params) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      Map<String, dynamic> params) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> updateUserDetails(Map<String, dynamic> params) {
    // TODO: implement updateUserDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<String, void>> verifyEmail(Map<String, dynamic> params) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
