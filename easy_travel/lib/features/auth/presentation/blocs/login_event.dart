abstract class LoginEvent {
  const LoginEvent();
}

class Login extends LoginEvent {
  const Login();
}

class OnEmailChanged extends LoginEvent {
  final String email;
  const OnEmailChanged({required this.email});
}

class OnPasswordChanged extends LoginEvent {
  final String password;
  const OnPasswordChanged({required this.password});
}

class TogglePasswordVisibility extends LoginEvent {
  const TogglePasswordVisibility();
}
