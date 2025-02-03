import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  String _connectionStatus = 'Unknown';


  String get connectionStatus => _connectionStatus;

  ConnectivityProvider() {
    _checkConnectivity();
    _subscribeToConnectivityChanges();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _subscribeToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      _connectionStatus = 'Connected';
      
    } else if (results.contains(ConnectivityResult.mobile)) {
      _connectionStatus = 'Connected';
      
    } else if (results.contains(ConnectivityResult.none)) {
      _connectionStatus = 'Disconnected';
      
    } else {
      _connectionStatus = 'Unknown';
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
