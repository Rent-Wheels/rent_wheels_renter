import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/firebase/domain/repository/firebase_auth_repository.dart';

class InitializeFirebase extends UseCase<void, NoParams> {
  final FirebaseAuthenticationRepository repository;

  InitializeFirebase({required this.repository});

  @override
  Future<Either<String, void>> call(NoParams params) async {
    return await repository.initialize();
  }
}