class Director {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Director({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Director.fromJson(Map<String, dynamic> json) {
    return Director(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
