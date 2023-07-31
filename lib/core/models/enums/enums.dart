enum Roles {
  user(id: 3921),
  admin(id: 9291),
  renter(id: 6631);

  const Roles({required this.id});

  final int id;
}

enum Status { success, failed }

enum ReservationStatus {
  accepted(status: 'Accepted'),
  pending(status: 'Pending'),
  rejected(status: 'Rejected'),
  cancelled(status: 'Cancelled');

  const ReservationStatus({required this.status});

  final String status;
}

enum CarReviewType { add, update }
