part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationIdle extends AuthenticationState {}

//State Designed for Completed Login Process
class AuthenticationLoggedIn extends AuthenticationState {
  const AuthenticationLoggedIn();
}

//State Designed for Completed Logout Process
class AuthenticationLoggedOut extends AuthenticationState {
  const AuthenticationLoggedOut();
}

//State Designed for Completed Logout Process
class AuthenticationSignedUp extends AuthenticationState {
  const AuthenticationSignedUp();
}
