import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/core/models/enums/enums.dart';
import 'package:rent_wheels_renter/src/cars/domain/entity/car_info.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/add_new_car.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/change_car_availability.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/delete_car.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/get_all_cars.dart';
import 'package:rent_wheels_renter/src/cars/domain/usecases/update_car_details.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final AddNewCar addNewCar;
  final DeleteCar deleteCar;
  final GetAllCars getAllCars;
  final UpdateCarDetails updateCarDetails;
  final ChangeCarAvailability changeCarAvailability;

  CarsBloc({
    required this.getAllCars,
    required this.addNewCar,
    required this.updateCarDetails,
    required this.changeCarAvailability,
    required this.deleteCar,
  }) : super(CarsInitial()) {
    on<GetAllCarsEvent>((event, emit) async {
      emit(GetAllCarsLoading());

      final response = await getAllCars(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarError(errorMessage: errorMessage),
          (response) => GetAllCarsLoaded(cars: response),
        ),
      );
    });

    on<AddNewCarEvent>((event, emit) async {
      emit(AddNewCarLoading());

      final response = await addNewCar(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarError(errorMessage: errorMessage),
          (response) => AddNewCarLoaded(car: response),
        ),
      );
    });

    on<UpdateCarDetailsEvent>((event, emit) async {
      emit(UpdateCarDetailsLoading());

      final response = await updateCarDetails(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarError(errorMessage: errorMessage),
          (response) => UpdateCarDetailsLoaded(car: response),
        ),
      );
    });

    on<ChangeCarAvailabilityEvent>((event, emit) async {
      emit(ChangeCarAvailabilityLoading());

      final response = await changeCarAvailability(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarError(errorMessage: errorMessage),
          (response) => ChangeCarAvailabilityLoaded(car: response),
        ),
      );
    });

    on<DeleteCarEvent>((event, emit) async {
      emit(DeleteCarLoading());

      final response = await deleteCar(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarError(errorMessage: errorMessage),
          (response) => DeleteCarLoaded(status: response),
        ),
      );
    });
  }
}
