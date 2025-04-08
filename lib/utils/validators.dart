bool isAValidEmail(value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return false;
  }
  return true;
}

bool isAValidUserName(value) {
  if (value.isEmpty) {
    return false;
  }
  return true;
}

bool isAValidPassword(value) {
  if (value == null || value.isEmpty) {
    return false;
  }

  if (value.length < 6) {
    return false;
  }

  return true;
}
