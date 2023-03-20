class InputUserData {
  String _email;
  String _password;
  String _phoneNumber;
  String _displayName;

  String? get email {
    return _email;
  }

  String? get password {
    return _password;
  }

  String? get phoneNumber {
    return _phoneNumber;
  }

  String? get displayName {
    return _displayName;
  }

  void updateEmail(String email) {
    if (email.isNotEmpty) {
      _email = email;
    }
  }

  void updatePassword(String password) {
    if (password.isNotEmpty) {
      _password = password;
    }
  }

  void updateDisplayName(String displayName) {
    if (displayName.isNotEmpty) {
      _displayName = displayName;
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      _phoneNumber = phoneNumber;
    }
  }

  InputUserData({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
  })  : _email = email,
        _password = password,
        _phoneNumber = phoneNumber,
        _displayName = displayName;
}
