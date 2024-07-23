import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/address_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';

part 'address.g.dart';

@HiveType(typeId: HiveTypes.address, adapterName: HiveAdapters.address)
@JsonSerializable()
class Address {
  @HiveField(AddressHFields.country)
  String? country;
  @HiveField(AddressHFields.street)
  String? street;
  @HiveField(AddressHFields.city)
  String? city;
  @HiveField(AddressHFields.state)
  String? state;
  @HiveField(AddressHFields.zip)
  String? zip;

  Address({this.country, this.street, this.city, this.state, this.zip});

  @override
  String toString() {
    return 'Address(country: $country, street: $street, city: $city, state: $state, zip: $zip)';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String get fullAdress => "$street, $city, $country";

  Address copyWith({
    String? country,
    String? street,
    String? city,
    String? state,
    String? zip,
  }) {
    return Address(
      country: country ?? this.country,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      country.hashCode ^
      street.hashCode ^
      city.hashCode ^
      state.hashCode ^
      zip.hashCode;
}
