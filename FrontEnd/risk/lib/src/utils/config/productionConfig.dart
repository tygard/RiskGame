import 'config.dart';

class ProductionConfig extends Config{
  String _endpoint = "PRODUCTION ENDPOINT";

  @override
  String getEndpoint() {
    return this._endpoint;
  }
}