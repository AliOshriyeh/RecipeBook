part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//Event Designed for Starting Auth Life cycle
class InitAuthEvent extends AuthenticationEvent {
  const InitAuthEvent();
}

//Event Designed for User Login
class LoginAuthEvent extends AuthenticationEvent {
  final String email;
  final String pass;

  const LoginAuthEvent(this.email, this.pass);

  @override
  List<Object> get props => [];
}

//Event Designed for User Logout
class LogoutAuthEvent extends AuthenticationEvent {
  const LogoutAuthEvent();
}

//Event Designed for User Signup
class SignupAuthEvent extends AuthenticationEvent {
  const SignupAuthEvent();
}
