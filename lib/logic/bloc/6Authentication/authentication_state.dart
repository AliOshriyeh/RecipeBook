// ignore_for_file: must_be_immutable

part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({this.status = UserLoginStatus.INITIAL, this.username, this.userpass, this.history});
  final UserLoginStatus status;
  final String? username;
  final String? userpass;
  final List<String>? history;

  AuthenticationState copyWith({
    required UserLoginStatus newStatus,
    String? newName,
    String? newPass,
    List<String>? newHis,
  }) {
    return AuthenticationState(
      status: newStatus, //Always Get the Status
      username: newName ?? username,
      userpass: newPass ?? userpass,
      history: newHis ?? history,
    );
  }

  @override
  List<Object> get props => [identityHashCode(this)]; //identityHashCode(this)
}

// class AuthenticationIdle extends AuthenticationState {}

// //State Designed for Recalling Login History
// class AuthenticationReady extends AuthenticationState {
//   final List storedLoginValue;
//   const AuthenticationReady(this.storedLoginValue);

//   @override
//   List<Object> get props => [storedLoginValue];
// }

// //State Designed for Loading Login Process
// class AuthenticationLogging extends AuthenticationState {
//   const AuthenticationLogging();
// }

// //State Designed for Completed Login Process
// class AuthenticationLoggedIn extends AuthenticationState {
//   const AuthenticationLoggedIn();
// }

// // //State Designed for Completed Logout Process
// // class AuthenticationLoggedOut extends AuthenticationState {}

// //State Designed for Completed Logout Process
// class AuthenticationSignedUp extends AuthenticationState {
//   const AuthenticationSignedUp();
// }
