enum Endpoints {
  login(value: '/users/login'),
  registerUser(value: '/renters/'),
  getRenter(value: '/renters/:renterId'),
  updateGetOrDeleteUser(value: '/users/:userId'),
  getRenterCars(value: '/renters/:renterId/cars'),
  upgradeToRenter(value: '/users/:userId/upgrade'),
  getOrDeleteUserReservationHistory(
    value: '/users/:userId/reservations/history',
  ),

  addCar(value: '/cars/'),
  updateOrDeleteCar(value: '/cars/:carId'),
  getCarHistory(value: '/cars/:carId/history'),
  changeAvailability(value: '/cars/:carId/availability'),

  getReservations(value: '/reservations/'),
  updateOrDeleteReservation(value: '/reservations/:reservationId/'),
  changeReservationStatus(value: '/reservations/:reservationId/status');

  const Endpoints({required this.value});

  final String value;
}
