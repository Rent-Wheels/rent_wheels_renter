import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/models/enums/auth.enum.dart';

abstract class FirebaseAuthProvider {
  Future<void> logout();

  Future<void> initialize();

  Future createUserWithEmailAndPassword({
    required String avatar,
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime dob,
    required String residence,
    required Roles role,
  });

  Future signInWithEmailAndPassword({
    required email,
    required password,
  });

  Future<void> resetPassword({
    required email,
  });

  Future<void> deleteUser({
    required User user,
  });

  Future<void> reauthenticateUser({
    required email,
    required password,
  });
}
