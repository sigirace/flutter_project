String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email cannot be empty";
  }

  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return "Invalid email address";
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password cannot be empty";
  }

  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }

  return null;
}
