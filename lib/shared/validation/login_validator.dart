class LoginValidator {
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is blank';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is blank';
    }

    return null;
  }
}