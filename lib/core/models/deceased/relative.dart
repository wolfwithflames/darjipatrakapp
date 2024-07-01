import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/relative_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';
import 'name.dart';

part 'relative.g.dart';

@HiveType(typeId: HiveTypes.relative, adapterName: HiveAdapters.relative)
@JsonSerializable()
class Relative extends HiveObject {
  @HiveField(RelativeHFields.name)
  Name? name;
  @JsonKey(name: '_id')
  @HiveField(RelativeHFields.id)
  String? id;
  @HiveField(RelativeHFields.relationship)
  String? relationship;
  @HiveField(RelativeHFields.gender)
  String? gender;

  Relative({this.name, this.id, this.relationship, this.gender});

  @override
  String toString() {
    return 'Relative(name: $name, id: $id, relationship: $relationship, gender: $gender)';
  }

  factory Relative.fromJson(Map<String, dynamic> json) {
    return _$RelativeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RelativeToJson(this);

  Relative copyWith({
    Name? name,
    String? id,
    String? relationship,
    String? gender,
  }) {
    return Relative(
      name: name ?? this.name,
      id: id ?? this.id,
      relationship: relationship ?? this.relationship,
      gender: gender ?? this.gender,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Relative) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^ id.hashCode ^ relationship.hashCode ^ gender.hashCode;
}
