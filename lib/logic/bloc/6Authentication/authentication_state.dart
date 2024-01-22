// ignore_for_file: must_be_immutable

part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationIdle extends AuthenticationState {}

class AuthenticationReady extends AuthenticationState {
  final List storedLoginValue;
  const AuthenticationReady(this.storedLoginValue);

  @override
  List<Object> get props => [storedLoginValue];
}

//State Designed for Completed Login Process
class AuthenticationLoggedIn extends AuthenticationState {
  const AuthenticationLoggedIn();
}

//State Designed for Completed Logout Process
class AuthenticationLoggedOut extends AuthenticationState {}

//State Designed for Completed Logout Process
class AuthenticationSignedUp extends AuthenticationState {
  const AuthenticationSignedUp();
}
