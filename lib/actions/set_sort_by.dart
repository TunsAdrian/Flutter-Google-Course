library set_sort_by;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_sort_by.freezed.dart';

@freezed
abstract class SetSortBy with _$SetSortBy {
  const factory SetSortBy(@nullable String sortBy) = _SetSortBy;
}
