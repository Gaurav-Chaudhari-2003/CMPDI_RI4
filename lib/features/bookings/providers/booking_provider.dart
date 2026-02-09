import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../models/booking.dart';

part 'booking_provider.freezed.dart';

// Provider to fetch the list of user's bookings
final bookingListProvider = FutureProvider<List<Booking>>((ref) async {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.fetchBookings();
});

// 1. Booking State (for create/update operations)
@freezed
class BookingState with _$BookingState {
  const factory BookingState.initial() = _Initial;
  const factory BookingState.loading() = _Loading;
  const factory BookingState.success(String message) = _Success;
  const factory BookingState.error(String error) = _Error;
}

// 2. Booking Repository
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository(ref.watch(apiServiceProvider));
});

class BookingRepository {
  final ApiService _apiService;

  BookingRepository(this._apiService);

  Future<List<Booking>> fetchBookings() async {
    try {
      final response = await _apiService.get(ApiConstants.bookingListUrl);
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw response.data['message'] ?? 'Failed to load bookings.';
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message ?? 'Network Error';
      throw 'Error: $errorMessage';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createBooking({
    required int vehicleId,
    required DateTime fromDateTime,
    required DateTime toDateTime,
    required String pickupLocation,
    required String dropLocation,
    required String purpose,
  }) async {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    final data = {
      'vehicle_id': vehicleId,
      'from_datetime': formatter.format(fromDateTime),
      'to_datetime': formatter.format(toDateTime),
      'pickup_location': pickupLocation,
      'drop_location': dropLocation,
      'purpose': purpose,
    };

    try {
      final response = await _apiService.post(ApiConstants.bookingCreateUrl, data: data);
      if (response.data['success'] != true) {
        throw response.data['message'] ?? 'Failed to create booking.';
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message ?? 'Network Error';
      throw 'Error: $errorMessage';
    } catch (e) {
      rethrow;
    }
  }
}

// 3. Booking Controller (for create/update operations)
final bookingControllerProvider = StateNotifierProvider<BookingController, BookingState>((ref) {
  return BookingController(ref.watch(bookingRepositoryProvider));
});

class BookingController extends StateNotifier<BookingState> {
  final BookingRepository _bookingRepository;

  BookingController(this._bookingRepository) : super(const BookingState.initial());

  Future<void> createBooking({
    required int vehicleId,
    required DateTime fromDateTime,
    required DateTime toDateTime,
    required String pickupLocation,
    required String dropLocation,
    required String purpose,
  }) async {
    state = const BookingState.loading();
    try {
      await _bookingRepository.createBooking(
        vehicleId: vehicleId,
        fromDateTime: fromDateTime,
        toDateTime: toDateTime,
        pickupLocation: pickupLocation,
        dropLocation: dropLocation,
        purpose: purpose,
      );
      state = const BookingState.success('Booking created successfully!');
    } catch (e) {
      state = BookingState.error(e.toString());
    }
  }
}
