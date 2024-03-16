class AuthUser {
  factory AuthUser.fromJson(
    Map<String, dynamic> json,
  ) =>
      AuthUser(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        password: json['password'],
      );
  AuthUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.password,
  });

  final String? uid;
  final String? email;
  final String? name;
  final String? password;

  AuthUser copyWith({
    String? uid,
    String? email,
    String? name,
    String? password,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
