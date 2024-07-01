import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/deceased_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';
import 'name.dart';
import 'relative.dart';

part 'deceased.g.dart';

@HiveType(typeId: HiveTypes.deceased, adapterName: HiveAdapters.deceased)
@JsonSerializable()
class Deceased extends HiveObject {
  @HiveField(DeceasedHFields.name)
  Name? name;
  @HiveField(DeceasedHFields.id)
  @JsonKey(name: '_id')
  String id;
  @HiveField(DeceasedHFields.dateOfBirth)
  @JsonKey(name: 'date_of_birth')
  DateTime? dateOfBirth;
  @HiveField(DeceasedHFields.dateOfDeath)
  @JsonKey(name: 'date_of_death')
  DateTime? dateOfDeath;
  @HiveField(DeceasedHFields.placeOfBirth)
  @JsonKey(name: 'place_of_birth')
  String? placeOfBirth;
  @HiveField(DeceasedHFields.placeOfDeath)
  @JsonKey(name: 'place_of_death')
  String? placeOfDeath;
  @HiveField(DeceasedHFields.occupation)
  String? occupation;
  @HiveField(DeceasedHFields.relatives)
  List<Relative>? relatives;
  @HiveField(DeceasedHFields.v)
  @JsonKey(name: '__v')
  int? v;
  @HiveField(DeceasedHFields.photoUrl)
  @JsonKey(name: 'photo_url')
  String? photoUrl;
  @HiveField(DeceasedHFields.tagline)
  @JsonKey(name: 'tagline')
  String? tagline;

  Deceased({
    this.name,
    required this.id,
    this.dateOfBirth,
    this.dateOfDeath,
    this.placeOfBirth,
    this.placeOfDeath,
    this.occupation,
    this.relatives,
    this.v,
    this.photoUrl,
    this.tagline,
  });

  @override
  String toString() {
    return 'Deceased(name: $name, id: $id, dateOfBirth: $dateOfBirth, dateOfDeath: $dateOfDeath, placeOfBirth: $placeOfBirth, placeOfDeath: $placeOfDeath, occupation: $occupation, relatives: $relatives, v: $v)';
  }

  factory Deceased.fromJson(Map<String, dynamic> json) {
    return _$DeceasedFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeceasedToJson(this);

  Deceased copyWith({
    Name? name,
    String? id,
    DateTime? dateOfBirth,
    DateTime? dateOfDeath,
    String? placeOfBirth,
    String? placeOfDeath,
    String? occupation,
    List<Relative>? relatives,
    int? v,
  }) {
    return Deceased(
      name: name ?? this.name,
      id: id ?? this.id,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfDeath: dateOfDeath ?? this.dateOfDeath,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      placeOfDeath: placeOfDeath ?? this.placeOfDeath,
      occupation: occupation ?? this.occupation,
      relatives: relatives ?? this.relatives,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Deceased) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      dateOfBirth.hashCode ^
      dateOfDeath.hashCode ^
      placeOfBirth.hashCode ^
      placeOfDeath.hashCode ^
      occupation.hashCode ^
      relatives.hashCode ^
      v.hashCode;

  String get fullName => "${name?.first} ${name?.last}";
}
