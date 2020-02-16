import 'config.dart';

class DebugConfig extends Config{
  String _endpoint = "localhost:8080";

  @override
  String getEndpoint() {
    return this._endpoint;
  }
}