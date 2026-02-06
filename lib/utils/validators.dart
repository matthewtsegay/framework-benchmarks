/// Form validation utilities for input fields

/// Validates that a value is not empty
String? validateRequired(String? value, {String fieldName = 'This field'}) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter $fieldName';
  }
  return null;
}

/// Validates email format
String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your email';
  }
  if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

/// Validates password with minimum length requirement
String? validatePassword(String? value, {int minLength = 6}) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < minLength) {
    return 'Password must be at least $minLength characters';
  }
  return null;
}

/// Validates full name (non-empty)
String? validateFullName(String? value) {
  return validateRequired(value, fieldName: 'your full name');
}
