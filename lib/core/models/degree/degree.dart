import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/degree_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';

part 'degree.g.dart';

@HiveType(
  typeId: HiveTypes.degree,
  adapterName: HiveAdapters.degree,
)
@JsonSerializable()
class Degree {
  @HiveField(DegreeHFields.id)
  @JsonKey(name: '_id')
  String? id;
  @HiveField(DegreeHFields.shortName)
  @JsonKey(name: 'short_name')
  String? shortName;
  @HiveField(DegreeHFields.fullName)
  @JsonKey(name: 'full_name')
  String? fullName;

  Degree({this.id, this.shortName, this.fullName});

  @override
  String toString() {
    return 'Degree(id: $id, shortName: $shortName, fullName: $fullName)';
  }

  factory Degree.fromJson(Map<String, dynamic> json) {
    return _$DegreeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DegreeToJson(this);

  Degree copyWith({
    String? id,
    String? shortName,
    String? fullName,
  }) {
    return Degree(
      id: id ?? this.id,
      shortName: shortName ?? this.shortName,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Degree) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ shortName.hashCode ^ fullName.hashCode;
}
