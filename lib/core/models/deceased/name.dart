import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/name_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';

part 'name.g.dart';

@HiveType(typeId: HiveTypes.name, adapterName: HiveAdapters.name)
@JsonSerializable()
class Name extends HiveObject {
  @HiveField(NameHFields.first)
  String? first;
  @HiveField(NameHFields.last)
  String? last;

  Name({this.first, this.last});

  @override
  String toString() => 'Name(first: $first, last: $last)';

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);

  Name copyWith({
    String? first,
    String? last,
  }) {
    return Name(
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Name) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => first.hashCode ^ last.hashCode;
}
