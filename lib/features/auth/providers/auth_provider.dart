import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/api/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/storage/secure_storage.dart';
import '../models/user.dart';

part 'auth_provider.freezed.dart';

// 1. Auth State Definition
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated({String? message}) = _Unauthenticated;
}

// 2. Auth Repository (Handles Data Logic)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiServiceProvider), SecureStorage());
});

class AuthRepository {
  final ApiService _apiService;
  final SecureStorage _secureStorage;

  AuthRepository(this._apiService, this._secureStorage);

  Future<User> login(String email, String password) async {
    final response = await _apiService.post(
      ApiConstants.loginUrl,
      data: {'email': email, 'password': password},
    );

    if (response.data['success'] == true && response.data['data']['token'] != null) {
      final token = response.data['data']['token'] as String;
      await _secureStorage.saveToken(token);
      return User.fromJson(response.data['data']['user'] as Map<String, dynamic>);
    } else {
      throw response.data['message'] ?? 'Login failed: An unknown error occurred.';
    }
  }

  Future<User> checkAuthStatus() async {
    try {
      final response = await _apiService.get(ApiConstants.userProfileUrl);
      if (response.data['success'] == true) {
        return User.fromJson(response.data['data'] as Map<String, dynamic>);
      }
      throw 'Invalid user data';
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _secureStorage.deleteToken();
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post(ApiConstants.logoutUrl);
    } finally {
      await _secureStorage.deleteToken();
    }
  }
}

// 3. Auth Controller (Manages State and Business Logic)
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.watch(authRepositoryProvider))..checkAuthStatus();
});

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final user = await _authRepository.checkAuthStatus();
      state = AuthState.authenticated(user);
    } catch (_) {
      state = const AuthState.unauthenticated();
    }
  }

  // MODIFIED: This method now returns the User on success or throws an error.
  Future<User> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _authRepository.login(email, password);
      state = AuthState.authenticated(user); // Still update the global state
      return user;
    } catch (e) {
      state = AuthState.unauthenticated(message: e.toString());
      rethrow; // Re-throw the error so the UI knows it failed
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
  }
}
