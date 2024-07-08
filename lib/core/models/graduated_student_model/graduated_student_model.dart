import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/graduated_student_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';
import '../deceased/name.dart';
import '../degree/degree.dart';

part 'graduated_student_model.g.dart';

@HiveType(
  typeId: HiveTypes.graduatedStudent,
  adapterName: HiveAdapters.graduatedStudent,
)
@JsonSerializable()
class GraduatedStudentModel {
  @HiveField(GraduatedStudentHFields.name)
  Name? name;
  @JsonKey(name: '_id')
  @HiveField(GraduatedStudentHFields.id)
  String id;
  @JsonKey(name: 'graduation_year')
  @HiveField(GraduatedStudentHFields.graduationYear)
  int? graduationYear;
  @HiveField(GraduatedStudentHFields.degree)
  Degree? degree;
  @JsonKey(name: 'profile_url')
  @HiveField(GraduatedStudentHFields.profileUrl)
  String? profileUrl;
  @JsonKey(name: 'passing_marks')
  @HiveField(GraduatedStudentHFields.passingMarks)
  int? passingMarks;
  @HiveField(GraduatedStudentHFields.city)
  String? city;

  GraduatedStudentModel({
    this.name,
    required this.id,
    this.graduationYear,
    this.degree,
    this.profileUrl,
    this.passingMarks,
    this.city,
  });

  @override
  String toString() {
    return 'GraduatedStudentModel(name: $name, id: $id, graduationYear: $graduationYear, degree: $degree, profileUrl: $profileUrl, passingMarks: $passingMarks, city: $city)';
  }

  factory GraduatedStudentModel.fromJson(Map<String, dynamic> json) {
    return _$GraduatedStudentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GraduatedStudentModelToJson(this);

  GraduatedStudentModel copyWith({
    Name? name,
    required String id,
    int? graduationYear,
    Degree? degree,
    String? profileUrl,
    int? passingMarks,
    String? city,
  }) {
    return GraduatedStudentModel(
      name: name ?? this.name,
      id: id,
      graduationYear: graduationYear ?? this.graduationYear,
      degree: degree ?? this.degree,
      profileUrl: profileUrl ?? this.profileUrl,
      passingMarks: passingMarks ?? this.passingMarks,
      city: city ?? this.city,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GraduatedStudentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      graduationYear.hashCode ^
      degree.hashCode ^
      profileUrl.hashCode ^
      passingMarks.hashCode ^
      city.hashCode;
}
