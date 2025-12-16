class CurrentUser {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String role;

  CurrentUser({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
    );
  }
}
