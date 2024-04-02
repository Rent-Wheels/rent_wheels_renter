import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels_renter/core/network/network_info.dart';
import 'package:rent_wheels_renter/src/authentication/data/datasources/localds.dart';
import 'package:rent_wheels_renter/src/authentication/data/datasources/remoteds.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/backend/backend_authentication_repo.dart';
import 'package:rent_wheels_renter/src/authentication/domain/repository/firebase/firebase_auth_repository.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

class AuthenticationRepository
    implements
        FirebaseAuthenticationRepository,
        BackendAuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthenticationRemoteDatasource remoteDatasource;
  final AuthenticationLocalDatasource localDatasource;

  AuthenticationRepository({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  // create user
  @override
  Future<Either<String, BackendUserInfo>> createOrUpdateUser(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response = await remoteDatasource.createOrUpdateUser(params);

      await localDatasource.cacheUserInfo(response);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // delete user
  @override
  Future<Either<String, void>> deleteUserFromBackend(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response = await remoteDatasource.deleteUserFromBackend(params);

      await localDatasource.deleteCachedUserInfo();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // logout
  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.createUserWithEmailAndPassword(
          email: params['email'], password: params['password']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
  // initialize firebase

  @override
  Future<Either<String, void>> deleteUserFromFirebase(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response =
          await remoteDatasource.deleteUserFromFirebase(user: params['user']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// sign in with email and password
  @override
  Future<Either<String, void>> logout() async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.logout();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// verify user
  @override
  Future<Either<String, UserCredential>> reauthenticateUser(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.reauthenticateUser(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// reset password
  @override
  Future<Either<String, void>> resetPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.resetPassword(
        email: params['email'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// delete user
  @override
  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.signInWithEmailAndPassword(
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// reauthenticate user
  @override
  Future<Either<String, void>> updateUserDetails(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.updateUserDetails(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// update user details
  @override
  Future<Either<String, void>> verifyEmail(Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.verifyEmail(user: params['user']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
