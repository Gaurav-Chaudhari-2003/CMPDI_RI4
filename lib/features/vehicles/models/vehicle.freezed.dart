// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return _Vehicle.fromJson(json);
}

/// @nodoc
mixin _$Vehicle {
  @StringToIntConverter()
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @StringToIntConverter()
  int get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'fuel_type')
  String get fuelType => throw _privateConstructorUsedError;
  @JsonKey(name: 'image')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'reg_no')
  String get regNo => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res, Vehicle>;
  @useResult
  $Res call({
    @StringToIntConverter() int id,
    String name,
    @StringToIntConverter() int capacity,
    @JsonKey(name: 'fuel_type') String fuelType,
    @JsonKey(name: 'image') String imageUrl,
    @JsonKey(name: 'reg_no') String regNo,
    String category,
    String? description,
    bool isAvailable,
  });
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res, $Val extends Vehicle>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? capacity = null,
    Object? fuelType = null,
    Object? imageUrl = null,
    Object? regNo = null,
    Object? category = null,
    Object? description = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            capacity:
                null == capacity
                    ? _value.capacity
                    : capacity // ignore: cast_nullable_to_non_nullable
                        as int,
            fuelType:
                null == fuelType
                    ? _value.fuelType
                    : fuelType // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                null == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String,
            regNo:
                null == regNo
                    ? _value.regNo
                    : regNo // ignore: cast_nullable_to_non_nullable
                        as String,
            category:
                null == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            isAvailable:
                null == isAvailable
                    ? _value.isAvailable
                    : isAvailable // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VehicleImplCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$$VehicleImplCopyWith(
    _$VehicleImpl value,
    $Res Function(_$VehicleImpl) then,
  ) = __$$VehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @StringToIntConverter() int id,
    String name,
    @StringToIntConverter() int capacity,
    @JsonKey(name: 'fuel_type') String fuelType,
    @JsonKey(name: 'image') String imageUrl,
    @JsonKey(name: 'reg_no') String regNo,
    String category,
    String? description,
    bool isAvailable,
  });
}

/// @nodoc
class __$$VehicleImplCopyWithImpl<$Res>
    extends _$VehicleCopyWithImpl<$Res, _$VehicleImpl>
    implements _$$VehicleImplCopyWith<$Res> {
  __$$VehicleImplCopyWithImpl(
    _$VehicleImpl _value,
    $Res Function(_$VehicleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? capacity = null,
    Object? fuelType = null,
    Object? imageUrl = null,
    Object? regNo = null,
    Object? category = null,
    Object? description = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _$VehicleImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        capacity:
            null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                    as int,
        fuelType:
            null == fuelType
                ? _value.fuelType
                : fuelType // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String,
        regNo:
            null == regNo
                ? _value.regNo
                : regNo // ignore: cast_nullable_to_non_nullable
                    as String,
        category:
            null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        isAvailable:
            null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleImpl implements _Vehicle {
  const _$VehicleImpl({
    @StringToIntConverter() required this.id,
    required this.name,
    @StringToIntConverter() required this.capacity,
    @JsonKey(name: 'fuel_type') required this.fuelType,
    @JsonKey(name: 'image') required this.imageUrl,
    @JsonKey(name: 'reg_no') required this.regNo,
    required this.category,
    this.description,
    this.isAvailable = true,
  });

  factory _$VehicleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleImplFromJson(json);

  @override
  @StringToIntConverter()
  final int id;
  @override
  final String name;
  @override
  @StringToIntConverter()
  final int capacity;
  @override
  @JsonKey(name: 'fuel_type')
  final String fuelType;
  @override
  @JsonKey(name: 'image')
  final String imageUrl;
  @override
  @JsonKey(name: 'reg_no')
  final String regNo;
  @override
  final String category;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isAvailable;

  @override
  String toString() {
    return 'Vehicle(id: $id, name: $name, capacity: $capacity, fuelType: $fuelType, imageUrl: $imageUrl, regNo: $regNo, category: $category, description: $description, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.fuelType, fuelType) ||
                other.fuelType == fuelType) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.regNo, regNo) || other.regNo == regNo) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    capacity,
    fuelType,
    imageUrl,
    regNo,
    category,
    description,
    isAvailable,
  );

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      __$$VehicleImplCopyWithImpl<_$VehicleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleImplToJson(this);
  }
}

abstract class _Vehicle implements Vehicle {
  const factory _Vehicle({
    @StringToIntConverter() required final int id,
    required final String name,
    @StringToIntConverter() required final int capacity,
    @JsonKey(name: 'fuel_type') required final String fuelType,
    @JsonKey(name: 'image') required final String imageUrl,
    @JsonKey(name: 'reg_no') required final String regNo,
    required final String category,
    final String? description,
    final bool isAvailable,
  }) = _$VehicleImpl;

  factory _Vehicle.fromJson(Map<String, dynamic> json) = _$VehicleImpl.fromJson;

  @override
  @StringToIntConverter()
  int get id;
  @override
  String get name;
  @override
  @StringToIntConverter()
  int get capacity;
  @override
  @JsonKey(name: 'fuel_type')
  String get fuelType;
  @override
  @JsonKey(name: 'image')
  String get imageUrl;
  @override
  @JsonKey(name: 'reg_no')
  String get regNo;
  @override
  String get category;
  @override
  String? get description;
  @override
  bool get isAvailable;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
