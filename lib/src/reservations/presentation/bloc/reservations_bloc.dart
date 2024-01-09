import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels_renter/src/reservations/domain/entity/reservation_info.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/get_all_reservations.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/get_car_rental_history.dart';
import 'package:rent_wheels_renter/src/reservations/domain/usecases/update_reservation_status.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final GetAllReservations getAllReservations;
  final GetCarRentalHistory getCarRentalHistory;
  final UpdateReservationStatus updateReservationStatus;
  ReservationsBloc({
    required this.getAllReservations,
    required this.getCarRentalHistory,
    required this.updateReservationStatus,
  }) : super(ReservationsInitial()) {
    on<GetAllReservationsEvent>((event, emit) async {
      emit(GetAllReservationsLoading());

      final response = await getAllReservations(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => GetAllReservationsLoaded(reservations: response),
        ),
      );
    });

    on<GetCarRentalHistoryEvent>((event, emit) async {
      emit(GetCarRentalHistoryLoading());

      final response = await getCarRentalHistory(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => GetCarRentalHistoryLoaded(reservations: response),
        ),
      );
    });

    on<UpdateReservationStatusEvent>((event, emit) async {
      emit(UpdateReservationStatusLoading());

      final response = await updateReservationStatus(event.params);

      emit(
        response.fold(
          (errorMessage) =>
              GenericReservationsError(errorMessage: errorMessage),
          (response) => UpdateReservationStatusLoaded(reservation: response),
        ),
      );
    });
  }
}
