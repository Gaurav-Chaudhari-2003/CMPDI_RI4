// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingImpl _$$BookingImplFromJson(Map<String, dynamic> json) =>
    _$BookingImpl(
      id: const StringToIntConverter().fromJson(json['id']),
      vehicle: json['vehicle'] as String,
      user: json['user'] as String,
      fromDateTime: json['from'] as String,
      toDateTime: json['to'] as String,
      pickupLocation: json['pickup'] as String,
      dropLocation: json['drop'] as String,
      status: json['status'] as String,
      vehicleImage: json['vehicle_image'] as String?,
      driverName: json['driver_name'] as String?,
      driverContact: json['driver_contact'] as String?,
    );

Map<String, dynamic> _$$BookingImplToJson(_$BookingImpl instance) =>
    <String, dynamic>{
      'id': const StringToIntConverter().toJson(instance.id),
      'vehicle': instance.vehicle,
      'user': instance.user,
      'from': instance.fromDateTime,
      'to': instance.toDateTime,
      'pickup': instance.pickupLocation,
      'drop': instance.dropLocation,
      'status': instance.status,
      'vehicle_image': instance.vehicleImage,
      'driver_name': instance.driverName,
      'driver_contact': instance.driverContact,
    };
