import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:blocapp/blocs/internet_bloc/internet_event.dart';
import 'package:blocapp/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivityStreamSubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetConnectedEvent>((event, emit) => emit(InternetConnectedState()));

    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetConnectedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
