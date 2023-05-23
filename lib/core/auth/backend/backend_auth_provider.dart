import 'package:rent_wheels_renter/core/models/auth/auth_model.dart';
import 'package:rent_wheels_renter/core/models/enums/auth.enum.dart';

abstract class BackendAuthProvider {
  Future<User> createUser({
    required String avatar,
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
    required Roles role,
  });
  Future<void> deleteUser({
    required String userId,
  });
}
