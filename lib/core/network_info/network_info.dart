import 'dart:async';

import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> currentNetworkConnection();
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> currentNetworkConnection() async {
    try {
      var connectivityResult = await (connectivity.checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
