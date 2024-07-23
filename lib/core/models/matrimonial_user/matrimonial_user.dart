import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/matrimonial_user_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';
import '../deceased/name.dart';
import 'address.dart';
import 'contact_info.dart';

part 'matrimonial_user.g.dart';

@HiveType(
    typeId: HiveTypes.matrimonialUser,
    adapterName: HiveAdapters.matrimonialUser)
@JsonSerializable()
class MatrimonialUser {
  @HiveField(MatrimonialUserHFields.name)
  Name? name;
  @HiveField(MatrimonialUserHFields.address)
  Address? address;
  @JsonKey(name: 'contact_info')
  @HiveField(MatrimonialUserHFields.contactInfo)
  ContactInfo? contactInfo;
  @HiveField(MatrimonialUserHFields.deleted)
  bool? deleted;
  @JsonKey(name: '_id')
  @HiveField(MatrimonialUserHFields.id)
  String? id;
  @JsonKey(name: 'date_of_birth')
  @HiveField(MatrimonialUserHFields.dateOfBirth)
  DateTime? dateOfBirth;
  @HiveField(MatrimonialUserHFields.gender)
  String? gender;
  @JsonKey(name: 'marital_status')
  @HiveField(MatrimonialUserHFields.maritalStatus)
  String? maritalStatus;
  @HiveField(MatrimonialUserHFields.caste)
  String? caste;
  @HiveField(MatrimonialUserHFields.religion)
  String? religion;
  @HiveField(MatrimonialUserHFields.education)
  String? education;
  @HiveField(MatrimonialUserHFields.occupation)
  String? occupation;
  @JsonKey(name: 'profile_url')
  @HiveField(MatrimonialUserHFields.profileUrl)
  String? profileUrl;

  MatrimonialUser({
    this.name,
    this.address,
    this.contactInfo,
    this.deleted,
    this.id,
    this.dateOfBirth,
    this.gender,
    this.maritalStatus,
    this.caste,
    this.religion,
    this.education,
    this.occupation,
    this.profileUrl,
  });

  @override
  String toString() {
    return 'MatrimonialUser(name: $name, address: $address, contactInfo: $contactInfo, deleted: $deleted, id: $id, dateOfBirth: $dateOfBirth, gender: $gender, maritalStatus: $maritalStatus, caste: $caste, religion: $religion, education: $education, occupation: $occupation, profileUrl: $profileUrl)';
  }

  factory MatrimonialUser.fromJson(Map<String, dynamic> json) {
    return _$MatrimonialUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MatrimonialUserToJson(this);

  MatrimonialUser copyWith({
    Name? name,
    Address? address,
    ContactInfo? contactInfo,
    bool? deleted,
    String? id,
    DateTime? dateOfBirth,
    String? gender,
    String? maritalStatus,
    String? caste,
    String? religion,
    String? education,
    String? occupation,
    String? profileUrl,
  }) {
    return MatrimonialUser(
      name: name ?? this.name,
      address: address ?? this.address,
      contactInfo: contactInfo ?? this.contactInfo,
      deleted: deleted ?? this.deleted,
      id: id ?? this.id,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      caste: caste ?? this.caste,
      religion: religion ?? this.religion,
      education: education ?? this.education,
      occupation: occupation ?? this.occupation,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MatrimonialUser) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      contactInfo.hashCode ^
      deleted.hashCode ^
      id.hashCode ^
      dateOfBirth.hashCode ^
      gender.hashCode ^
      maritalStatus.hashCode ^
      caste.hashCode ^
      religion.hashCode ^
      education.hashCode ^
      occupation.hashCode ^
      profileUrl.hashCode;

  String get fullName => "${name?.first} ${name?.last}";
}
