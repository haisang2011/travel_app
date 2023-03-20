final RegExp _emailRegex = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

final RegExp _passwordRegex = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
);

class SignUpValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    } else {
      return _emailRegex.hasMatch(email) ? null : "Here is not a invalid email";
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Email cannot be empty";
    } else {
      return _passwordRegex.hasMatch(password)
          ? null
          : "Here is not a invalid password";
    }
  }

  static String? validateName(String? name) {
    return name == null || name.isEmpty ? "Name cannot be empty" : null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    return phoneNumber == null || phoneNumber.isEmpty ? "Phone number" : null;
  }
}
