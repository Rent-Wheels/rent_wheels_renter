import 'package:dartz/dartz.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/files/domain/repository/file_repository.dart';

class DeleteDirectory extends UseCase<void, Map<String, dynamic>> {
  final FileRepository repository;

  DeleteDirectory({required this.repository});

  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteDirectory(params);
  }
}
