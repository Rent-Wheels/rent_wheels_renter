part of 'cars_bloc.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

final class CarsInitial extends CarsState {}

final class GetAllCarsLoading extends CarsState {}

final class GetAllCarsLoaded extends CarsState {
  final List<CarInfo> cars;

  const GetAllCarsLoaded({required this.cars});
}

final class AddNewCarLoading extends CarsState {}

final class AddNewCarLoaded extends CarsState {
  final CarInfo car;

  const AddNewCarLoaded({required this.car});
}

final class UpdateCarDetailsLoading extends CarsState {}

final class UpdateCarDetailsLoaded extends CarsState {
  final CarInfo car;

  const UpdateCarDetailsLoaded({required this.car});
}

final class ChangeCarAvailabilityLoading extends CarsState {}

final class ChangeCarAvailabilityLoaded extends CarsState {
  final CarInfo car;

  const ChangeCarAvailabilityLoaded({required this.car});
}

final class DeleteCarLoading extends CarsState {}

final class DeleteCarLoaded extends CarsState {
  final Status status;

  const DeleteCarLoaded({required this.status});
}

final class GenericCarError extends CarsState {
  final String errorMessage;

  const GenericCarError({required this.errorMessage});
}
