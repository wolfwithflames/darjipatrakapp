import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/contact_info_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';

part 'contact_info.g.dart';

@HiveType(typeId: HiveTypes.contactInfo, adapterName: HiveAdapters.contactInfo)
@JsonSerializable()
class ContactInfo {
  @HiveField(ContactInfoHFields.phone)
  String? phone;
  @HiveField(ContactInfoHFields.email)
  String? email;

  ContactInfo({this.phone, this.email});

  @override
  String toString() => 'ContactInfo(phone: $phone, email: $email)';

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return _$ContactInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);

  ContactInfo copyWith({
    String? phone,
    String? email,
  }) {
    return ContactInfo(
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ContactInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => phone.hashCode ^ email.hashCode;
}
