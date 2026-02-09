import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cmpdiri4/core/converters/string_to_int_converter.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    @StringToIntConverter() required int id,
    required String name,
    @StringToIntConverter() required int capacity,
    @JsonKey(name: 'fuel_type') required String fuelType,
    @JsonKey(name: 'image') required String imageUrl,
    @JsonKey(name: 'reg_no') required String regNo,
    required String category,
    String? description,
    @Default(true) bool isAvailable,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
}
