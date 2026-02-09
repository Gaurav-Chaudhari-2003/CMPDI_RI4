import 'package:cmpdiri4/core/converters/string_to_int_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    @StringToIntConverter() required int id,
    required String vehicle,
    required String user,
    @JsonKey(name: 'from') required String fromDateTime,
    @JsonKey(name: 'to') required String toDateTime,
    @JsonKey(name: 'pickup') required String pickupLocation,
    @JsonKey(name: 'drop') required String dropLocation,
    required String status,
    // Optional fields for approved bookings
    @JsonKey(name: 'vehicle_image') String? vehicleImage,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_contact') String? driverContact,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
}
