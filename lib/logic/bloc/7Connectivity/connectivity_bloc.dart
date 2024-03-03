import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:test/utils/constants/enums.dart';
import 'package:test/utils/constants/globals.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final connectivityCheck = Connectivity();
  late StreamSubscription connectivityStreamSubscription;
  ConnectivityBloc() : super(ConnectivityLoading()) {
    on<ConnectivityInitialEvent>((event, emit) {
      print(printSignifier + "START");
      emit(ConnectionFailure());
    });

    on<ConnectivityMonitorEvent>((event, emit) {
      connectivityStreamSubscription = connectivityCheck.onConnectivityChanged.listen((connectivityResult) {
        //   if (connectivityResult == ConnectivityResult.wifi) {
        //     setStateToConnected(ConnectivityType.WIFI);
        //   } else if (connectivityResult == ConnectivityResult.mobile) {
        //     setStateToConnected(ConnectivityType.MobileData);
        //   } else if (connectivityResult == ConnectivityResult.none) {
        //     setStateToDisconnected();
        //   }
        emit(ConnectionFailure());
      });
    });

    // on<ConnectivityEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    // void setStateToConnected(ConnectivityType connType) => emit(ConnectionSuccess(type: connType));
    // void setStateToDisconnected() => emit(ConnectionFailure());
  }
  // @override
  // Future<void> close() {
  //   connectivityStreamSubscription.cancel();
  //   return super.close();
  // }
}
