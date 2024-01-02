import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/core/usecase/usecase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/backend/create_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/backend/delete_user_from_backend.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/create_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/delete_user_from_firebase.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/logout.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/reauthenticate_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/reset_password.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/sign_in.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/update_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/verify_email.dart';

import 'package:rent_wheels_renter/src/user/domain/entity/user_info.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Logout logout;
  final VerifyEmail verifyEmail;
  final ResetPassword resetPassword;
  final UpdateUserDetails updateUserDetails;
  final ReauthenticateUser reauthenticateUser;
  final CreateOrUpdateUser createOrUpdateUser;
  final DeleteUserFromBackend deleteUserFromBackend;
  final DeleteUserFromFirebase deleteUserFromFirebase;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final CreateUserWithEmailAndPassword createUserWithEmailAndPassword;

  AuthenticationBloc({
    required this.logout,
    required this.verifyEmail,
    required this.resetPassword,
    required this.updateUserDetails,
    required this.reauthenticateUser,
    required this.createOrUpdateUser,
    required this.deleteUserFromBackend,
    required this.deleteUserFromFirebase,
    required this.signInWithEmailAndPassword,
    required this.createUserWithEmailAndPassword,
  }) : super(AuthenticationInitial()) {
    //!BACKEND

    on<CreateOrUpdateUserEvent>((event, emit) async {
      emit(CreateUpdateUserLoading());
      final response = await createOrUpdateUser(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericBackendAuthError(errorMessage: errorMessage),
          (response) => CreateUpdateUserLoaded(user: response),
        ),
      );
    });

    on<DeleteUserFromBackendEvent>((event, emit) async {
      emit(DeleteUserFromBackendLoading());

      final response = await deleteUserFromBackend(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericBackendAuthError(errorMessage: errorMessage),
          (_) => DeleteUserFromBackendLoaded(),
        ),
      );
    });

    //!FIREBASE

    on<CreateUserWithEmailAndPasswordEvent>((event, emit) async {
      emit(CreateUserWithEmailAndPasswordLoading());

      final response = await createUserWithEmailAndPassword(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (response) => CreateUserWithEmailAndPasswordLoaded(user: response),
        ),
      );
    });

    on<DeleteUserFromFirebaseEvent>((event, emit) async {
      emit(DeleteUserFromFirebaseLoading());

      final response = await deleteUserFromFirebase(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (_) => DeleteUserFromFirebaseLoaded(),
        ),
      );
    });

    on<ReauthenticateUserEvent>((event, emit) async {
      emit(ReauthenticateUserLoading());

      final response = await reauthenticateUser(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (response) => ReauthenticateUserLoaded(user: response),
        ),
      );
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoading());

      final response = await resetPassword(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (_) => ResetPasswordLoaded(),
        ),
      );
    });

    on<SignInWithEmailAndPasswordEvent>((event, emit) async {
      emit(SignInWithEmailAndPasswordLoading());

      final response = await signInWithEmailAndPassword(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (response) => SignInWithEmailAndPasswordLoaded(user: response),
        ),
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading());

      final response = await updateUserDetails(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (_) => UpdateUserLoaded(),
        ),
      );
    });

    on<VerifyEmailEvent>((event, emit) async {
      emit(VerifyEmailLoading());

      final response = await verifyEmail(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (_) => VerifyEmailLoaded(),
        ),
      );
    });

    on<InitializeFirebaseEvent>((event, emit) async {
      emit(InitializeFirebaseLoaded());
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());

      final response = await logout(NoParams());

      emit(
        response.fold(
          (errorMessage) => GenericFirebaseAuthError(
            errorMessage: errorMessage,
          ),
          (_) => LogoutLoaded(),
        ),
      );
    });
  }
}
