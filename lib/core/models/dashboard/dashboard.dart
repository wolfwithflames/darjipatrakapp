import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../hive_helper/fields/dashboard_h_fields.dart';
import '../../hive_helper/hive_adapters.dart';
import '../../hive_helper/hive_types.dart';
import '../deceased/deceased.dart';
import '../graduated_student_model/graduated_student_model.dart';
import '../matrimonial_user/matrimonial_user.dart';

part 'dashboard.g.dart';

@HiveType(typeId: HiveTypes.dashboard, adapterName: HiveAdapters.dashboard)
@JsonSerializable()
class DashboardModel extends HiveObject {
  DashboardModel({
    this.deceased,
    this.matrimonialUsers,
    this.students,
  });
  @HiveField(DashboardModelHFields.deceased)
  List<Deceased>? deceased;
  @HiveField(DashboardModelHFields.matrimonialUsers)
  List<MatrimonialUser>? matrimonialUsers;
  @HiveField(DashboardModelHFields.students)
  List<GraduatedStudentModel>? students;

  @override
  String toString() {
    return 'DashboardModel(deceased: $deceased, matrimonialUsers: $matrimonialUsers, students: $students)';
  }

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return _$DashboardModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
}
