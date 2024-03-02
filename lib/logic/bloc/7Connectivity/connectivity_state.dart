part of 'connectivity_bloc.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

final class ConnectivityLoading extends ConnectivityState {}

class ConnectionSuccess extends ConnectivityState {
  const ConnectionSuccess({required this.type});

  final ConnectivityType type;
}

final class ConnectionFailure extends ConnectivityState {}
