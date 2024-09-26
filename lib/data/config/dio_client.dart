import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ecommerce/config/endpoints_config.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService(BuildContext context) {
    _dio.options.baseUrl = EndpointsConfig.backendUrl;
    _dio.options.connectTimeout = Duration(seconds: 10); // Connection timeout
    _dio.options.receiveTimeout = Duration(seconds: 10); // Receive timeout

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Modify the request (e.g., add headers or tokens)
          options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // Handle responses globally
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          print("Error: $error");
          if (error.type == 401) {
            print("Error.data: ${error.response?.data}");
            // Handle 401 error, show alert or navigate to login
            // CustomSnackbar(
            //       message: error.response.data,
            //       context: context)
            //   .showSnackbar();
          } else {
            // Pass other errors through
            handler.next(error);
          }
        },
      ),
    );
  }

  // GET Request
  Future<Response> get(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  // POST Request
  Future<Response> post(String endpoint, dynamic data) async {
    try {
      return await _dio.post(endpoint, data: jsonEncode(data));
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  // PUT Request
  Future<Response> put(String endpoint, dynamic data) async {
    try {
      return await _dio.put(endpoint, data: jsonEncode(data));
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  // DELETE Request
  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
