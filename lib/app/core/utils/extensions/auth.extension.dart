extension AuthExtension on String? {
  String? get validateEmail {
    if (this == null || this!.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? get validateName {
    if (this == null || this!.isEmpty) {
      return 'Name is required';
    } else if (this!.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? get validatePassword {
    if (this == null || this!.isEmpty) {
      return 'Password is required';
    } else if (this!.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
