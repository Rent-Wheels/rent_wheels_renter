part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllCarsEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const GetAllCarsEvent({required this.params});
}

final class AddNewCarEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const AddNewCarEvent({required this.params});
}

final class UpdateCarDetailsEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const UpdateCarDetailsEvent({required this.params});
}

final class ChangeCarAvailabilityEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const ChangeCarAvailabilityEvent({required this.params});
}

final class DeleteCarEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const DeleteCarEvent({required this.params});
}
