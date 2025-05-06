import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'no_internet_event.dart';
part 'no_internet_state.dart';

class NoInternetBloc extends Bloc<NoInternetEvent, NoInternetState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _subscription;

  NoInternetBloc() : super(ConnectivityInitial()) {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      add(ConnectivityChanged(!result.contains(ConnectivityResult.none)));
    });

    on<ConnectivityChanged>(_onConnectivityChanged);
    on<CheckConnectivity>(_checkInternetConnection);
  }

  void _checkInternetConnection(
    CheckConnectivity event,
    Emitter<NoInternetState> emit,
  ) async {
    final result = await _connectivity.checkConnectivity();
    add(ConnectivityChanged(!result.contains(ConnectivityResult.none)));
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<NoInternetState> emit,
  ) {
    if (event.isConnected) {
      emit(ConnectivityConnected());
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
