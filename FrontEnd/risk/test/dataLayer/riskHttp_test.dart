import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:risk/dataLayer/riskHttp.dart';
import 'package:risk/src/utils/serviceProviders.dart';

main() {
  test('Should establish HTTP connection between client and server', () async {
    //creates dependencies to be injected
    registerServices();

    Response response = await RiskHttp.makePostRequest("/test", params: {"test": "BLAH"});
    Map<String, dynamic> body = (json.decode(response.data));

    expect(response.statusCode, 200);
    expect(body["test"], "BLAH");
  });
}
