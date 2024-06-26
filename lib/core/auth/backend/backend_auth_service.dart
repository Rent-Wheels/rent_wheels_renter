import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels_renter/core/auth/auth_exceptions.dart';
import 'package:rent_wheels_renter/core/models/user/user_model.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/backend/files/file_methods.dart';
import 'package:rent_wheels_renter/core/auth/backend/backend_auth_provider.dart';

class BackendAuthService implements BackendAuthProvider {
  @override
  Future<BackendUser> createUser({
    required String avatar,
    required User user,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  }) async {
    final ext = avatar.split('.').last;
    try {
      final profilePicture = await RentWheelsFilesMethods().getFileUrl(
        file: File(avatar),
        filePath: 'users/${user.uid}/avatar/${user.uid}.$ext',
      );

      final response = await post(
        Uri.parse('${global.baseURL}/renters/'),
        body: {
          'userId': user.uid,
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'dob': dob.toIso8601String(),
          'placeOfResidence': residence,
          'profilePicture': profilePicture
        },
      );

      if (response.statusCode == 201) {
        return BackendUser.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      await user.delete();
      RentWheelsFilesMethods()
          .deleteFile(filePath: 'users/${user.uid}/avatar/${user.uid}.$ext');
      throw Exception(e);
    }
  }

  @override
  Future<BackendUser> updateUser({
    required String? avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  }) async {
    try {
      final ext = avatar?.split('.').last;
      String? profilePicture;
      if (avatar != null) {
        profilePicture = await RentWheelsFilesMethods().getFileUrl(
            file: File(avatar),
            filePath:
                'users/${global.user!.uid}/avatar/${global.user!.uid}.$ext');
      }

      final response = await patch(
        Uri.parse('${global.baseURL}/users/${global.user!.uid}'),
        headers: global.headers,
        body: {
          'userId': global.user!.uid,
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'dob': dob.toIso8601String(),
          'placeOfResidence': residence,
          'profilePicture': profilePicture ?? global.userDetails!.profilePicture
        },
      );

      if (response.statusCode == 200) {
        return BackendUser.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  deleteUser({required String userId}) async {
    final response = await delete(
      Uri.parse('${global.baseURL}/users/$userId'),
      headers: global.headers,
    );

    if (response.statusCode != 200) throw GenericAuthException();
  }
}
