import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http/adapter.dart';

import '../ApiResponse/mobile_api_response.dart';

class ApiClient {
  Dio? _dio;
  final String _baseUrl =
      "https://192.168.1.9:45455/api/"; // Conveyor Remote URL

  // Callbacks
  Function(MobileApiResponse)? onResponseCallback;
  Function(MobileApiResponse)? onErrorCallback;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json; charset=utf-8",
        "X-Requested-With": "XMLHttpRequest",
      },
    ));

    (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return dioClient;
    };

    initializeInterceptors();
  }

  void initializeInterceptors() {
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, requestInterceptorHandler) {
        // TODO: Add token if needed
        // String token = LocalSharedPreference.getString(LocalSharedPreference.SHARED_MEM_KEY_DEVICE_TOKEN);
        // if (token.isNotEmpty) {
        //   options.headers["Authorization"] = "Bearer $token";
        // }
        return requestInterceptorHandler.next(options);
      },
      onResponse: (response, responseInterceptorHandler) {
        log('Response: ${response.statusCode}');
        onResponseCallback
            ?.call(MobileApiResponse()); // Or, provide more details here
        return responseInterceptorHandler.next(response);
      },
      onError: (error, errorInterceptorHandler) {
        if (error.response != null) {
          final statusCode = error.response!.statusCode;
          switch (statusCode) {
            case 400:
              print("Bad Request");
              break;
            case 401:
              print("Unauthorized");
              break;
            case 404:
              print("Not Found");
              break;
            default:
              print("Error: ${error.message}");
          }
          MobileApiResponse apiResponse = MobileApiResponse();
          apiResponse.errorMessage =
              error.response?.data["message"] ?? error.message;
          onErrorCallback?.call(apiResponse);
        }
        return errorInterceptorHandler.next(error);
      },
    ));
  }

  Future<Response> getRequest(String endPoint,
      {Map<String, dynamic>? filter}) async {
    try {
      final response = await _dio!.get(endPoint, queryParameters: filter);
      log("GET Response: ${response.toString()}");
      return response;
    } catch (e) {
      log("GET Request Error: $e");
      rethrow;
    }
  }

  Future<Response> postRequest(String endPoint, dynamic formData) async {
    try {
      final response = await _dio!.post(endPoint, data: formData);
      log("POST Response: ${response.toString()}");
      return response;
    } catch (e) {
      log("POST Request Error: $e");
      rethrow;
    }
  }

  Future<Response> postRequestQueryString(
      String endPoint, dynamic formData) async {
    try {
      final queryString = Transformer.urlEncodeMap(formData);
      final response = await _dio!.post('$endPoint?$queryString');
      log("POST Query String Response: ${response.toString()}");
      return response;
    } catch (e) {
      log("POST Query String Request Error: $e");
      rethrow;
    }
  }

  Future<Response> deleteById(String endPoint) async {
    try {
      final response = await _dio!.delete(endPoint);
      log("DELETE Response: ${response.toString()}");
      return response;
    } catch (e) {
      log("DELETE Request Error: $e");
      rethrow;
    }
  }

  Future<Response> uploadPhoto(String endPoint, File photo) async {
    try {
      final formData = FormData.fromMap({
        "ImageFile": await MultipartFile.fromFile(photo.path,
            filename: photo.uri.pathSegments.last),
      });
      final response = await _dio!.post(endPoint, data: formData);
      log("Upload Photo Response: ${response.toString()}");
      return response;
    } catch (e) {
      log("Upload Photo Error: $e");
      rethrow;
    }
  }

  Future<Response> getRequestToken(String endpoint,
      {Map<String, dynamic>? filter}) async {
    try {
      final response = await _dio!.get(endpoint, queryParameters: filter);
      log("GET Response with Token: ${response.toString()}");
      return response;
    } catch (e) {
      log("GET Request with Token Error: $e");
      rethrow;
    }
  }
}
