class AuthUser {
  factory AuthUser.fromJson(
    Map<String, dynamic> json,
  ) =>
      AuthUser(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
      );
  AuthUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  final String uid;
  final String email;
  final String name;
  String? error;

  AuthUser copyWith({
    String? uid,
    String? email,
    String? name,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  String? get userError {
    return error;
  }

  set userError(String? value) {
    error = value;
  }
}
