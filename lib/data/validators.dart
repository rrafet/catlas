String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Enter your email.';
  if (!email.contains('@') || !email.contains('.')) {
    return 'Enter a valid email address.';
  }
  return null;
}

String? validatePassword(String? value) {
  final password = value ?? '';
  if (password.isEmpty) return 'Enter your password.';
  if (password.length < 8) return 'Password must be at least 8 characters.';
  return null;
}
