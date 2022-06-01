final RegExp _emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return "Required";
  if (!_emailRegex.hasMatch(value)) return "The E-mail Address must be a valid email address.";
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return "Required";
  if (value.length < 8 || value.length > 72) return "Password must be between 8 and 72 characters long";

  return null;
}