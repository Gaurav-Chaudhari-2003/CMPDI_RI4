import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../models/vehicle.dart';

/// A class to hold our filter state. Using a class ensures that we can
/// easily add more filters in the future.
@immutable
class VehicleFilter {
  const VehicleFilter({this.from, this.to});
  final DateTime? from;
  final DateTime? to;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleFilter &&
          runtimeType == other.runtimeType &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}

/// Provider to hold the current filter state.
/// This will be updated by the UI when the user selects dates.
final vehicleFilterProvider = StateProvider<VehicleFilter>((ref) {
  return const VehicleFilter();
});

/// Provider for the VehicleRepository.
final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return VehicleRepository(ref.watch(apiServiceProvider));
});

/// This provider will fetch the list of vehicles, automatically re-fetching
/// when the [vehicleFilterProvider] changes.
final vehicleListProvider = FutureProvider<List<Vehicle>>((ref) async {
  final vehicleRepository = ref.watch(vehicleRepositoryProvider);
  final filter = ref.watch(vehicleFilterProvider);
  // Pass the filter dates to the repository method.
  return vehicleRepository.fetchVehicles(from: filter.from, to: filter.to);
});

class VehicleRepository {
  final ApiService _apiService;

  VehicleRepository(this._apiService);

  /// Fetches vehicles from the API.
  ///
  /// Takes optional [from] and [to] `DateTime` parameters to filter
  /// the results for available vehicles.
  Future<List<Vehicle>> fetchVehicles({DateTime? from, DateTime? to}) async {
    try {
      final params = <String, String>{};

      // If both dates are provided, format them and add to the query parameters.
      if (from != null && to != null) {
        // Format to "YYYY-MM-DD HH:mm" to match the API expectation.
        String formatDateTime(DateTime dt) {
          return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
        }

        params['filter_from'] = formatDateTime(from);
        params['filter_to'] = formatDateTime(to);
      }

      final response = await _apiService.get(
        ApiConstants.vehicleListUrl,
        queryParameters: params,
      );

      if (response.data['success'] == true) {
        // The API might return null for 'data' if no vehicles are found.
        final List<dynamic>? vehicleData = response.data['data'];
        if (vehicleData == null) {
          return []; // Return an empty list if there's no data.
        }
        return vehicleData.map((json) {
          try {
            return Vehicle.fromJson(json);
          } catch (e, s) {
            log('Error parsing vehicle from JSON: $json', error: e, stackTrace: s);
            rethrow;
          }
        }).toList();
      } else {
        throw response.data['message'] ?? 'Failed to load vehicles.';
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message ?? 'Network Error';
      throw 'Error: $errorMessage';
    } catch (e) {
      rethrow;
    }
  }
}
