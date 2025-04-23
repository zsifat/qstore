import 'package:connectivity_plus/connectivity_plus.dart';

import 'api_client.dart';

class NetworkChecker {
  static final NetworkChecker _instance = NetworkChecker._internal();
  final Connectivity _connectivity = Connectivity();

  factory NetworkChecker() {
    return _instance;
  }

  NetworkChecker._internal();

  Future<bool> get hasConnection async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return await _isConnectedToInternet();
    }
    else {
      return false;
    }
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      final response = await ApiClient.instance.get('https://example.com');
      return true;
    } catch (e) {
      print("Error checking internet connection: $e");
      return false;
    }
  }
}