// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of set_sort_by;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SetSortByTearOff {
  const _$SetSortByTearOff();

// ignore: unused_element
  _SetSortBy call(@nullable String sortBy) {
    return _SetSortBy(
      sortBy,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SetSortBy = _$SetSortByTearOff();

/// @nodoc
mixin _$SetSortBy {
  @nullable
  String get sortBy;

  $SetSortByCopyWith<SetSortBy> get copyWith;
}

/// @nodoc
abstract class $SetSortByCopyWith<$Res> {
  factory $SetSortByCopyWith(SetSortBy value, $Res Function(SetSortBy) then) =
      _$SetSortByCopyWithImpl<$Res>;
  $Res call({@nullable String sortBy});
}

/// @nodoc
class _$SetSortByCopyWithImpl<$Res> implements $SetSortByCopyWith<$Res> {
  _$SetSortByCopyWithImpl(this._value, this._then);

  final SetSortBy _value;
  // ignore: unused_field
  final $Res Function(SetSortBy) _then;

  @override
  $Res call({
    Object sortBy = freezed,
  }) {
    return _then(_value.copyWith(
      sortBy: sortBy == freezed ? _value.sortBy : sortBy as String,
    ));
  }
}

/// @nodoc
abstract class _$SetSortByCopyWith<$Res> implements $SetSortByCopyWith<$Res> {
  factory _$SetSortByCopyWith(
          _SetSortBy value, $Res Function(_SetSortBy) then) =
      __$SetSortByCopyWithImpl<$Res>;
  @override
  $Res call({@nullable String sortBy});
}

/// @nodoc
class __$SetSortByCopyWithImpl<$Res> extends _$SetSortByCopyWithImpl<$Res>
    implements _$SetSortByCopyWith<$Res> {
  __$SetSortByCopyWithImpl(_SetSortBy _value, $Res Function(_SetSortBy) _then)
      : super(_value, (v) => _then(v as _SetSortBy));

  @override
  _SetSortBy get _value => super._value as _SetSortBy;

  @override
  $Res call({
    Object sortBy = freezed,
  }) {
    return _then(_SetSortBy(
      sortBy == freezed ? _value.sortBy : sortBy as String,
    ));
  }
}

/// @nodoc
class _$_SetSortBy implements _SetSortBy {
  const _$_SetSortBy(@nullable this.sortBy);

  @override
  @nullable
  final String sortBy;

  @override
  String toString() {
    return 'SetSortBy(sortBy: $sortBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SetSortBy &&
            (identical(other.sortBy, sortBy) ||
                const DeepCollectionEquality().equals(other.sortBy, sortBy)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(sortBy);

  @override
  _$SetSortByCopyWith<_SetSortBy> get copyWith =>
      __$SetSortByCopyWithImpl<_SetSortBy>(this, _$identity);
}

abstract class _SetSortBy implements SetSortBy {
  const factory _SetSortBy(@nullable String sortBy) = _$_SetSortBy;

  @override
  @nullable
  String get sortBy;
  @override
  _$SetSortByCopyWith<_SetSortBy> get copyWith;
}
