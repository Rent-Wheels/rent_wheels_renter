import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/network/network_info.dart';
import 'package:rent_wheels_renter/src/authentication/backend/data/datasources/localds.dart';
import 'package:rent_wheels_renter/src/authentication/backend/data/datasources/remoteds.dart';
import 'package:rent_wheels_renter/src/authentication/backend/domain/repository/backend_authentication_repo.dart';
import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

class BackendAuthenticationRepositoryImpl
    implements BackendAuthenticationRepository {
  final NetworkInfo networkInfo;
  final BackendAuthenticationRemoteDatasource remoteDatasource;
  final BackendAuthenticationLocalDatasource localDatasource;

  BackendAuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  // create user
  @override
  Future<Either<String, UserInfo>> createOrUpdateUser(
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
  Future<Either<String, void>> deleteUser(Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response = await remoteDatasource.deleteUser(params);

      await localDatasource.deleteCachedUserInfo();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
