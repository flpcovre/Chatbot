String? isAValidEmail(value) {
  if (value == null || value.isEmpty) {
    return 'O campo de e-mail não pode estar vazio';
  }
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Insira um e-mail válido';
  }
  return null;
}

String? isAValidUserName(value) {
  if (value.isEmpty) {
    return 'O campo nome do usuário não pode estar vazio';
  }
  return null;
}

String? isAValidPassword(value) {
  if (value == null || value.isEmpty) {
    return 'A senha não pode estar vazia';
  }

  if (value.length < 6) {
    return 'A senha deve conter pelo menos 6 caracteres';
  }

  String pattern = r'^(?=.*[0-9]).+$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'A senha deve conter pelo menos 1 caractere numérico.';
  }
  return null;
}
