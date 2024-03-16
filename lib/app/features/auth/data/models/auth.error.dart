class AuthError {
  AuthError();
  String? _message;

  String? getError() {
    return _message;
  }

  set errorMessage(String? value) {
    _message = value;
  }
}
