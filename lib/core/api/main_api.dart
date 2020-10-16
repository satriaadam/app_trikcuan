import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class MainApi {
  String host = 'http://localhost/mbahgiso-api/public';
  Dio dio = Dio();
  String get getHost => host;

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: ""
  };

  Future<String> postRequest({
    String url,
    Object body,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer " + prefs.getString("apiToken");
    print('REQUEST_POST: $url');
    print('REQUEST_HEADER: $headers');
    print('REQUEST_BODY: $body');
    try {
      final response = await dio.post<String>(
        url, 
        data: jsonEncode(body),
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200) {
        return jsonEncode(jsonDecode(response.data));
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.data)['message'];
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
  
  Future<String> patchRequest({
    String url,
    Object body,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer " + prefs.getString("apiToken");
    print('REQUEST_PATCH: $url');
    print('REQUEST_HEADER: $headers');
    print('REQUEST_BODY: $body');
    try {
      final response = await dio.patch<String>(
        url,
        data: body,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200) {
        return jsonEncode(jsonDecode(response.data));
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.data)['message'];
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }

  Future<String> getRequest({
    String url,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(useAuth) {
      this.headers[HttpHeaders.authorizationHeader] = "Bearer " + prefs.getString("apiToken");
    }
    print('REQUEST_GET: $url');
    print('REQUEST_HEADER: $headers');
    try {
      final response = await dio.get<String>(
        url,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200) {
        return jsonEncode(jsonDecode(response.data));
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.data)['message'];
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
  
  Future<String> deleteRequest({
    String url,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(useAuth) {
      this.headers[HttpHeaders.authorizationHeader] = "Bearer " + prefs.getString("apiToken");
    }
    print('REQUEST_DELETE: $url');
    print('REQUEST_HEADER: $headers');
    try {
      final response = await dio.delete<String>(
        url,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200) {
        return jsonEncode(jsonDecode(response.data));
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.data)['message'];
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
}