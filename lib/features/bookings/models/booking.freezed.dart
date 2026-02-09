// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  @StringToIntConverter()
  int get id => throw _privateConstructorUsedError;
  String get vehicle => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'from')
  String get fromDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'to')
  String get toDateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup')
  String get pickupLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'drop')
  String get dropLocation => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // Optional fields for approved bookings
  @JsonKey(name: 'vehicle_image')
  String? get vehicleImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_name')
  String? get driverName => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_contact')
  String? get driverContact => throw _privateConstructorUsedError;

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call({
    @StringToIntConverter() int id,
    String vehicle,
    String user,
    @JsonKey(name: 'from') String fromDateTime,
    @JsonKey(name: 'to') String toDateTime,
    @JsonKey(name: 'pickup') String pickupLocation,
    @JsonKey(name: 'drop') String dropLocation,
    String status,
    @JsonKey(name: 'vehicle_image') String? vehicleImage,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_contact') String? driverContact,
  });
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicle = null,
    Object? user = null,
    Object? fromDateTime = null,
    Object? toDateTime = null,
    Object? pickupLocation = null,
    Object? dropLocation = null,
    Object? status = null,
    Object? vehicleImage = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            vehicle:
                null == vehicle
                    ? _value.vehicle
                    : vehicle // ignore: cast_nullable_to_non_nullable
                        as String,
            user:
                null == user
                    ? _value.user
                    : user // ignore: cast_nullable_to_non_nullable
                        as String,
            fromDateTime:
                null == fromDateTime
                    ? _value.fromDateTime
                    : fromDateTime // ignore: cast_nullable_to_non_nullable
                        as String,
            toDateTime:
                null == toDateTime
                    ? _value.toDateTime
                    : toDateTime // ignore: cast_nullable_to_non_nullable
                        as String,
            pickupLocation:
                null == pickupLocation
                    ? _value.pickupLocation
                    : pickupLocation // ignore: cast_nullable_to_non_nullable
                        as String,
            dropLocation:
                null == dropLocation
                    ? _value.dropLocation
                    : dropLocation // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            vehicleImage:
                freezed == vehicleImage
                    ? _value.vehicleImage
                    : vehicleImage // ignore: cast_nullable_to_non_nullable
                        as String?,
            driverName:
                freezed == driverName
                    ? _value.driverName
                    : driverName // ignore: cast_nullable_to_non_nullable
                        as String?,
            driverContact:
                freezed == driverContact
                    ? _value.driverContact
                    : driverContact // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
    _$BookingImpl value,
    $Res Function(_$BookingImpl) then,
  ) = __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @StringToIntConverter() int id,
    String vehicle,
    String user,
    @JsonKey(name: 'from') String fromDateTime,
    @JsonKey(name: 'to') String toDateTime,
    @JsonKey(name: 'pickup') String pickupLocation,
    @JsonKey(name: 'drop') String dropLocation,
    String status,
    @JsonKey(name: 'vehicle_image') String? vehicleImage,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_contact') String? driverContact,
  });
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
    _$BookingImpl _value,
    $Res Function(_$BookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicle = null,
    Object? user = null,
    Object? fromDateTime = null,
    Object? toDateTime = null,
    Object? pickupLocation = null,
    Object? dropLocation = null,
    Object? status = null,
    Object? vehicleImage = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
  }) {
    return _then(
      _$BookingImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        vehicle:
            null == vehicle
                ? _value.vehicle
                : vehicle // ignore: cast_nullable_to_non_nullable
                    as String,
        user:
            null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                    as String,
        fromDateTime:
            null == fromDateTime
                ? _value.fromDateTime
                : fromDateTime // ignore: cast_nullable_to_non_nullable
                    as String,
        toDateTime:
            null == toDateTime
                ? _value.toDateTime
                : toDateTime // ignore: cast_nullable_to_non_nullable
                    as String,
        pickupLocation:
            null == pickupLocation
                ? _value.pickupLocation
                : pickupLocation // ignore: cast_nullable_to_non_nullable
                    as String,
        dropLocation:
            null == dropLocation
                ? _value.dropLocation
                : dropLocation // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        vehicleImage:
            freezed == vehicleImage
                ? _value.vehicleImage
                : vehicleImage // ignore: cast_nullable_to_non_nullable
                    as String?,
        driverName:
            freezed == driverName
                ? _value.driverName
                : driverName // ignore: cast_nullable_to_non_nullable
                    as String?,
        driverContact:
            freezed == driverContact
                ? _value.driverContact
                : driverContact // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    @StringToIntConverter() required this.id,
    required this.vehicle,
    required this.user,
    @JsonKey(name: 'from') required this.fromDateTime,
    @JsonKey(name: 'to') required this.toDateTime,
    @JsonKey(name: 'pickup') required this.pickupLocation,
    @JsonKey(name: 'drop') required this.dropLocation,
    required this.status,
    @JsonKey(name: 'vehicle_image') this.vehicleImage,
    @JsonKey(name: 'driver_name') this.driverName,
    @JsonKey(name: 'driver_contact') this.driverContact,
  });

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  @StringToIntConverter()
  final int id;
  @override
  final String vehicle;
  @override
  final String user;
  @override
  @JsonKey(name: 'from')
  final String fromDateTime;
  @override
  @JsonKey(name: 'to')
  final String toDateTime;
  @override
  @JsonKey(name: 'pickup')
  final String pickupLocation;
  @override
  @JsonKey(name: 'drop')
  final String dropLocation;
  @override
  final String status;
  // Optional fields for approved bookings
  @override
  @JsonKey(name: 'vehicle_image')
  final String? vehicleImage;
  @override
  @JsonKey(name: 'driver_name')
  final String? driverName;
  @override
  @JsonKey(name: 'driver_contact')
  final String? driverContact;

  @override
  String toString() {
    return 'Booking(id: $id, vehicle: $vehicle, user: $user, fromDateTime: $fromDateTime, toDateTime: $toDateTime, pickupLocation: $pickupLocation, dropLocation: $dropLocation, status: $status, vehicleImage: $vehicleImage, driverName: $driverName, driverContact: $driverContact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.fromDateTime, fromDateTime) ||
                other.fromDateTime == fromDateTime) &&
            (identical(other.toDateTime, toDateTime) ||
                other.toDateTime == toDateTime) &&
            (identical(other.pickupLocation, pickupLocation) ||
                other.pickupLocation == pickupLocation) &&
            (identical(other.dropLocation, dropLocation) ||
                other.dropLocation == dropLocation) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.vehicleImage, vehicleImage) ||
                other.vehicleImage == vehicleImage) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverContact, driverContact) ||
                other.driverContact == driverContact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    vehicle,
    user,
    fromDateTime,
    toDateTime,
    pickupLocation,
    dropLocation,
    status,
    vehicleImage,
    driverName,
    driverContact,
  );

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(this);
  }
}

abstract class _Booking implements Booking {
  const factory _Booking({
    @StringToIntConverter() required final int id,
    required final String vehicle,
    required final String user,
    @JsonKey(name: 'from') required final String fromDateTime,
    @JsonKey(name: 'to') required final String toDateTime,
    @JsonKey(name: 'pickup') required final String pickupLocation,
    @JsonKey(name: 'drop') required final String dropLocation,
    required final String status,
    @JsonKey(name: 'vehicle_image') final String? vehicleImage,
    @JsonKey(name: 'driver_name') final String? driverName,
    @JsonKey(name: 'driver_contact') final String? driverContact,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  @StringToIntConverter()
  int get id;
  @override
  String get vehicle;
  @override
  String get user;
  @override
  @JsonKey(name: 'from')
  String get fromDateTime;
  @override
  @JsonKey(name: 'to')
  String get toDateTime;
  @override
  @JsonKey(name: 'pickup')
  String get pickupLocation;
  @override
  @JsonKey(name: 'drop')
  String get dropLocation;
  @override
  String get status; // Optional fields for approved bookings
  @override
  @JsonKey(name: 'vehicle_image')
  String? get vehicleImage;
  @override
  @JsonKey(name: 'driver_name')
  String? get driverName;
  @override
  @JsonKey(name: 'driver_contact')
  String? get driverContact;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
