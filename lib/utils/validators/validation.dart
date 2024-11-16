class TValidator {
  // Empty Text Validator
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  // Birthday Validator
  static String? validateBirthday(String? value) {
    if (value == null || value.isEmpty) {
      return 'Birthday is required.';
    }

    // Regular expression for date format DD/MM/YYYY
    final dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (!dateRegExp.hasMatch(value)) {
      return 'Invalid date format (DD/MM/YYYY required).';
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Check if the month is valid (1-12)
      if (month < 1 || month > 12) {
        return 'Invalid month.';
      }

      // Check if the day is valid for the month
      final maxDaysInMonth = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > maxDaysInMonth) {
        return 'Invalid day for the selected month.';
      }

      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();
      final age = today.year -
          birthDate.year -
          (today.isBefore(birthDate.add(Duration(days: 365 * (today.year - birthDate.year)))) ? 1 : 0);

      if (age < 18) {
        return 'You must be at least 18 years old.';
      }
    } catch (_) {
      return 'Invalid birthday.';
    }

    return null;
  }
}
