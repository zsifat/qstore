abstract class NetworkConnectivityEvent {}

class NetworkStatusChanged extends NetworkConnectivityEvent {
  final bool isConnected;

  NetworkStatusChanged(this.isConnected);
}
