import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

import 'package:rent_wheels_renter/core/urls/urls.dart';
import 'package:rent_wheels_renter/core/network/network_info.dart';

import 'package:rent_wheels_renter/src/authentication/data/datasources/localds.dart';
import 'package:rent_wheels_renter/src/authentication/data/datasources/remoteds.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/logout.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/sign_in.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/backend/create_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/create_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/update_user.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/verify_email.dart';
import 'package:rent_wheels_renter/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/reset_password.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/firebase/reauthenticate_user.dart';
import 'package:rent_wheels_renter/src/authentication/data/repository/authentication_repository_impl.dart';
import 'package:rent_wheels_renter/src/authentication/domain/usecases/backend/delete_user_from_backend.dart';

import 'package:rent_wheels_renter/src/cars/data/datasources/remoteds.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/delete_car.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/add_new_car.dart';
import 'package:rent_wheels_renter/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/get_all_cars.dart';
import 'package:rent_wheels_renter/src/cars/data/repository/cars_repo_impl.dart';
import 'package:rent_wheels_renter/src/cars/domain/repository/cars_repository.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/update_car_details.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/change_car_availability.dart';

import 'package:rent_wheels_renter/src/files/data/datasources/remoteds.dart';
import 'package:rent_wheels_renter/src/files/domain/usecases/delete_file.dart';
import 'package:rent_wheels_renter/src/files/domain/usecases/get_file_url.dart';
import 'package:rent_wheels_renter/src/files/presentation/bloc/files_bloc.dart';
import 'package:rent_wheels_renter/src/files/domain/usecases/delete_directory.dart';
import 'package:rent_wheels_renter/src/files/domain/repository/file_repository.dart';
import 'package:rent_wheels_renter/src/files/data/repository/files_repository_impl.dart';

import 'package:rent_wheels_renter/src/reservations/data/datasource/remoteds.dart';
import 'package:rent_wheels_renter/src/reservations/presentation/bloc/reservations_bloc.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/get_all_reservations.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/get_car_rental_history.dart';
import 'package:rent_wheels_renter/src/reservations/domain/repository/reservation_repository.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/update_reservation_status.dart';
import 'package:rent_wheels_renter/src/reservations/data/repository/reservation_repository_impl.dart';

final sl = GetIt.instance;

init() async {
  //!INTERNAL

  //AUTHENTICATION
  initAuth();

  //CARS
  initCars();

  //FILES
  initFiles();

  //RESERVATIONS
  initReservations();

  //!EXTERNAL

  //LOCAL STORAGE
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  //FIREBASE
  sl
    ..registerLazySingleton(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton(
      () => FirebaseStorage.instance,
    );

  //NETWORK RESOURCES
  sl
    ..registerLazySingleton(
      () => Client(),
    )
    ..registerLazySingleton(
      () => Urls(),
    )
    ..registerLazySingleton(
      () => DataConnectionChecker(),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        dataConnectionChecker: sl(),
      ),
    );
}

//AUTHENTICATION
initAuth() {
  //bloc
  sl.registerFactory(
    () => AuthenticationBloc(
      logout: sl(),
      verifyEmail: sl(),
      resetPassword: sl(),
      updateUserDetails: sl(),
      reauthenticateUser: sl(),
      createOrUpdateUser: sl(),
      deleteUserFromBackend: sl(),
      deleteUserFromFirebase: sl(),
      signInWithEmailAndPassword: sl(),
      createUserWithEmailAndPassword: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => Logout(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => VerifyEmail(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ResetPassword(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUserDetails(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ReauthenticateUser(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateOrUpdateUser(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteUserFromBackend(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignInWithEmailAndPassword(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateUserWithEmailAndPassword(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton(
    () => AuthenticationRepository(
      networkInfo: sl(),
      localDatasource: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl
    ..registerLazySingleton(
      () => AuthenticationRemoteDatasource(
        client: sl(),
        url: sl(),
        firebase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AuthenticationLocalDatasource(
        sharedPreferences: sl(),
      ),
    );
}

//CARS
initCars() {
  //bloc
  sl.registerFactory(
    () => CarsBloc(
      getAllCars: sl(),
      addNewCar: sl(),
      updateCarDetails: sl(),
      changeCarAvailability: sl(),
      deleteCar: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => GetAllCars(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AddNewCar(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateCarDetails(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ChangeCarAvailability(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteCar(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<CarsRepository>(
    () => CarsRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<CarsRemoteDatasource>(
    () => CarsRemoteDatasourceImpl(
      urls: sl(),
      client: sl(),
    ),
  );
}

//FILES
initFiles() {
  //bloc
  sl.registerFactory(
    () => FilesBloc(
      getFileUrl: sl(),
      deleteFile: sl(),
      deleteDirectory: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => GetFileUrl(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteFile(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteDirectory(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<FileRepository>(
    () => FileRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<FilesRemoteDatasource>(
    () => FilesRemoteDatasourceImpl(
      storage: sl(),
    ),
  );
}

//RESERVATIONS
initReservations() {
  //bloc
  sl.registerFactory(
    () => ReservationsBloc(
      getAllReservations: sl(),
      getCarRentalHistory: sl(),
      updateReservationStatus: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => GetAllReservations(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetCarRentalHistory(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateReservationStatus(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<ReservationRemoteDatasource>(
    () => ReservationRemoteDatasourceImpl(
      client: sl(),
      urls: sl(),
    ),
  );
}
