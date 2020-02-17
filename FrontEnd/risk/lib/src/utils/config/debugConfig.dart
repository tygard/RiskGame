import 'config.dart';

class DebugConfig extends Config{
  String _endpoint = "coms-309-yt-2.cs.iastate.edu:8080";

  @override
  String getEndpoint() {
    return this._endpoint;
  }
}