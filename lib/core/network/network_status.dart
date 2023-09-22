import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkStatus {
  Future<bool>? get isConnected;
}

class NetworkStatusImpl implements NetworkStatus {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkStatusImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
