// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      id: const StringToIntConverter().fromJson(json['id']),
      name: json['name'] as String,
      capacity: const StringToIntConverter().fromJson(json['capacity']),
      fuelType: json['fuel_type'] as String,
      imageUrl: json['image'] as String,
      regNo: json['reg_no'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'id': const StringToIntConverter().toJson(instance.id),
      'name': instance.name,
      'capacity': const StringToIntConverter().toJson(instance.capacity),
      'fuel_type': instance.fuelType,
      'image': instance.imageUrl,
      'reg_no': instance.regNo,
      'category': instance.category,
      'description': instance.description,
      'isAvailable': instance.isAvailable,
    };
