

class Validator {
  static String? validateEmail(String value) {
    const Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    const Pattern pattern = r'^.{6,}$';
    final regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String value, String password) {
    if (validatePassword(value) != null) {
      return 'Password must be at least  6 characters';
    } else if (value != password) {
      return 'Passwords does not match!';
    } else {
      return null;
    }
  }

  static String? validateText(String value, String label) {
    if (value.isEmpty || value.length < 3) {
      return '$label is invalid';
    } else {
      return null;
    }
  }

  static String? validateBVN(String value) {
    if (value.length < 11) {
      return 'BVN is invalid';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'This field is required.';
    } else if (!(value.length > 6 && value.length < 20)) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? validateFullName(String value) {
    if (value.isEmpty) {
      return 'This field is required.';
    } else if (!value.contains(' ') || value.length < 4) {
      return 'Enter a valid full name';
    } else {
      return null;
    }
  }
}