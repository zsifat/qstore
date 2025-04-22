import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../../core/services/network_services/network_checker.dart';
import 'network_connectivity_event.dart';
import 'network_connectivity_state.dart';

class NetworkConnectivityBloc extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  NetworkConnectivityBloc() : super(NetworkInitial()) {
    on<NetworkStatusChanged>((event, emit) {
      if (event.isConnected) {
        emit(NetworkConnected());
      } else {
        emit(NetworkDisconnected());
      }
    });

    _subscription = _connectivity.onConnectivityChanged.listen((result) async {
      bool hasInternet = await NetworkChecker().hasConnection;
      add(NetworkStatusChanged(hasInternet));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
