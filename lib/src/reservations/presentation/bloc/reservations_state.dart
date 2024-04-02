part of 'reservations_bloc.dart';

sealed class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object> get props => [];
}

final class ReservationsInitial extends ReservationsState {}

final class GetAllReservationsLoading extends ReservationsState {}

final class GetAllReservationsLoaded extends ReservationsState {
  final List<ReservationInfo> reservations;

  const GetAllReservationsLoaded({required this.reservations});
}

final class GetCarRentalHistoryLoading extends ReservationsState {}

final class GetCarRentalHistoryLoaded extends ReservationsState {
  final List<ReservationInfo> reservations;

  const GetCarRentalHistoryLoaded({required this.reservations});
}

final class UpdateReservationStatusLoading extends ReservationsState {}

final class UpdateReservationStatusLoaded extends ReservationsState {
  final ReservationInfo reservation;

  const UpdateReservationStatusLoaded({required this.reservation});
}

final class GenericReservationsError extends ReservationsState {
  final String errorMessage;

  const GenericReservationsError({required this.errorMessage});
}
