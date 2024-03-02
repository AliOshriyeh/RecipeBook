part of 'connectivity_bloc.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityInitialEvent extends ConnectivityEvent {}

class ConnectivityMonitorEvent extends ConnectivityEvent {}
