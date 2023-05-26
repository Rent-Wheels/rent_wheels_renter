class BackendUser {
  String id;
  String userId;
  String name;
  String email;
  DateTime dob;
  String phoneNumber;
  num role;
  String profilePicture;

  BackendUser({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.role,
    required this.profilePicture,
  });

  factory BackendUser.fromJSON(Map<String, dynamic> json) {
    return BackendUser(
        id: json['_id'],
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        dob: DateTime.parse(json['dob']),
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        profilePicture: json['profilePicture']);
  }
}
