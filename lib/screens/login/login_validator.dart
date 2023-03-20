final RegExp _emailRegex = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

class LoginValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    } else {
      return _emailRegex.hasMatch(email) ? null : "Here is not a invalid email";
    }
  }

  static String? validatePassword(String? password) {
    return password == null || password.isEmpty
        ? "Password cannot be empty"
        : null;
  }
}
