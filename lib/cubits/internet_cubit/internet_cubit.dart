import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// If all state classes are empty means they have no data then we can use enum
enum InternetState { initial, lost, connected }

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivityStreamSubscription;

  InternetCubit() : super(InternetState.initial) {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.connected);
      } else {
        emit(InternetState.lost);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
