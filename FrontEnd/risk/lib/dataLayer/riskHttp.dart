import 'package:dio/dio.dart';
import 'package:risk/src/utils/config/config.dart';
import 'package:risk/src/utils/serviceProviders.dart';

//gives base HTTP request
abstract class RiskHttp {
  static Dio _dio = new Dio();

  static Future<Response> makePostRequest(String endpoint,
      {Map<String, dynamic> params}) async {

    //creates url string 
    String url = endpoint;
    if (url[0] != "/") url = "/" + url;
    if (url[endpoint.length - 1] != "/") url = url + "/";
    url = "http://${locator<Config>().getEndpoint()}$url";

    Response response;
    if (params != null){
           response = await _dio.post(url,
        data: params,
        options: new Options(contentType: 'application/x-www-form-urlencoded'));
    return response;
    } else {
          response = await _dio.get(url,
        options: new Options(contentType: 'application/x-www-form-urlencoded'));
    return response;
    }
  }
}

class NetworkException extends Error {}

//not an error:
//check if the response is a proper APIkey, if it is move on
//open up the error and display it
