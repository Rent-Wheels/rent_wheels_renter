part of 'reservations_bloc.dart';

sealed class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllReservationsEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const GetAllReservationsEvent({required this.params});
}

final class GetCarRentalHistoryEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const GetCarRentalHistoryEvent({required this.params});
}

final class UpdateReservationStatusEvent extends ReservationsEvent {
  final Map<String, dynamic> params;

  const UpdateReservationStatusEvent({required this.params});
}
