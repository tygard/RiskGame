import 'package:dio/dio.dart';

//gives base HTTP request
abstract class RiskHttp {
  static Dio _dio = new Dio();

  static Future<Map<String, Object>> makePostRequest(String endpoint,
      {Map<String, String> params}) async {

    //creates url string 
    String url = endpoint;
    if (url[0] != "/") url = "/" + url;
    if (url[endpoint.length - 1] != "/") url = url + "/";
    url = "http://localhost:8080/REST$url";

    Response response;
    if (params != null){
           response = await _dio.post(url,
        data: params,
        options: new Options(contentType: 'application/x-www-form-urlencoded'));
    return response.data;
    } else {
          response = await _dio.get(url,
        options: new Options(contentType: 'application/x-www-form-urlencoded'));
    return response.data;
    }
  }
}

class NetworkException extends Error {}

//not an error:
//check if the response is a proper APIkey, if it is move on
//open up the error and display it
