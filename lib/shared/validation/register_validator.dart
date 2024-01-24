class RegisterValidator {
  String? validateName(String? username) {
    if (username == null || username.isEmpty) {
      return 'Name is blank';
    }

    return null;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is blank';
    }

    var phoneRegex = RegExp(r'^(\+0?1\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
    var isValidPhone = phoneRegex.hasMatch(phone);
    if (isValidPhone == false) {
      return 'Phone number is invalid.';
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is blank';
    }

    var emailRegex = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    var isValidEmail = emailRegex.hasMatch(email);
    if (isValidEmail == false) {
      return 'Email is invalid.';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is blank';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters.';
    }

    return null;
  }

  String? validateConfirmPassword(String? password, String? passwordToCompare) {
    if (password == null || password.isEmpty || passwordToCompare == null || passwordToCompare.isEmpty) {
      return 'Password is blank';
    }

    if (password != passwordToCompare) {
      return 'Passwords do not match.';
    }

    return null;
  }

  String? validateCheckbox(bool? checkbox, String checkboxName) {
    if (checkbox == null) {
      return 'Please agree to $checkboxName';
    }

    return null;
  }
}