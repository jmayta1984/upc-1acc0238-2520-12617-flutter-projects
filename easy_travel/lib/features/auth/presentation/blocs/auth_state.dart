enum AuthStatus { initial, loading, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;

  const AuthState({this.status = AuthStatus.initial});

  AuthState copyWith({AuthStatus? status}) {
    return AuthState(status: status ?? this.status);
  }
}
