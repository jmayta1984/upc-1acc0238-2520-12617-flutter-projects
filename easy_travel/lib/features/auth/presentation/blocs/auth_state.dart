import 'package:easy_travel/features/auth/domain/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState({required this.user});
}

class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState({required this.message});
}
