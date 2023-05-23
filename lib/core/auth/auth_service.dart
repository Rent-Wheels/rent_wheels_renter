import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/models/enums/auth.enum.dart';
import 'package:rent_wheels_renter/core/auth/firebase/firebase_auth_service.dart';
import 'package:rent_wheels_renter/core/auth/firebase/firebase_auth_provider.dart';

class AuthService implements FirebaseAuthProvider {
  final FirebaseAuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthService());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> logout() => provider.logout();

  @override
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
  }) =>
      provider.createUserWithEmailAndPassword(
        avatar: avatar,
        userId: userId,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        dob: dob,
        residence: residence,
        role: role,
      );

  @override
  Future signInWithEmailAndPassword({
    required email,
    required password,
  }) =>
      provider.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> resetPassword({
    required email,
  }) =>
      provider.resetPassword(email: email);

  @override
  Future<void> deleteUser({
    required User user,
  }) =>
      provider.deleteUser(user: user);

  @override
  Future<void> reauthenticateUser({
    required email,
    required password,
  }) =>
      provider.reauthenticateUser(email: email, password: password);
}
