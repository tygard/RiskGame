import 'config.dart';

class DebugConfig extends Config{
  String _endpoint = "10.0.2.2:8080";

  @override
  String getEndpoint() {
    return this._endpoint;
  }
}