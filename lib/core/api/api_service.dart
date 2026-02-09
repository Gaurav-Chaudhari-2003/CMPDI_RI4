import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

/// Provider to make ApiService available throughout the app
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(SecureStorage());
});

class ApiService {
  final Dio _dio;
  final SecureStorage _secureStorage;

  ApiService(this._secureStorage)
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Accept': 'application/json',
            // Content-Type will be added on a per-request basis
          },
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // If you switch back to ngrok, add the header here:
          // options.headers['ngrok-skip-browser-warning'] = 'true';

          // Do not add token to public routes
          if (options.path != ApiConstants.loginUrl) {
            final token = await _secureStorage.readToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log responses in debug mode
          if (kDebugMode) {
            print('Response: ${response.statusCode} ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('DioError: ${e.response?.statusCode} ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// Generic GET method
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException {
      // Re-throw the DioException to be handled by the caller
      rethrow;
    }
  }

  /// Generic POST method
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(
        path, 
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } on DioException {
      rethrow;
    }
  }

  /// Generic PATCH method
  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(
        path, 
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } on DioException {
      rethrow;
    }
  }

  /// Cancels a booking by sending a POST request
  Future<void> cancelBooking(int bookingId) async {
    await post(ApiConstants.bookingCancelUrl, data: {'booking_id': bookingId});
  }

  // You can add other methods like PUT, DELETE as needed.
}
