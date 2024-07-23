import 'package:hive/hive.dart';

import '../../../getIt.dart';
import '../../constants/local_storage_keys.dart';
import '../../exceptions/cache_exception.dart';
import '../../hive_helper/hive_types.dart';
import '../../models/degree/degree.dart';
import '../../models/graduated_student_model/graduated_student_model.dart';
import '../../utils/file_helper.dart';

abstract class GraduatedStudentsLocalDataSource {
  Future<void> init();

  Future<List<GraduatedStudentModel>> fetchGraduatedStudents();

  Future<void> cacheGraduatedStudentModels(
      List<GraduatedStudentModel> draduatedStudentModel);
}

class GraduatedStudentsLocalDataSourceImpl
    implements GraduatedStudentsLocalDataSource {
  final _fileHelper = getIt<FileHelper>();
  final _hiveService = getIt<HiveInterface>();

  bool get _isBoxOpen =>
      _hiveService.isBoxOpen(LocalStorageKeys.graduatedStudent);
  Box<GraduatedStudentModel> get _studentsBox => _hiveService
      .box<GraduatedStudentModel>(LocalStorageKeys.graduatedStudent);

  @override
  Future<void> cacheGraduatedStudentModels(
      List<GraduatedStudentModel> draduatedStudentModel) async {
    final graduatedMap = <String, GraduatedStudentModel>{};
    for (var graduated in draduatedStudentModel) {
      graduatedMap.addAll({graduated.id!: graduated});
    }

    await _studentsBox.putAll(graduatedMap);
  }

  @override
  Future<List<GraduatedStudentModel>> fetchGraduatedStudents() async {
    if (_studentsBox.isEmpty) {
      throw const CacheException('No GraduatedStudents found in cache');
    }

    return _studentsBox.values
        .map<GraduatedStudentModel>(
          (deceased) => GraduatedStudentModel.fromJson(deceased.toJson()),
        )
        .toList();
  }

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    if (!Hive.isAdapterRegistered(HiveTypes.degree)) {
      Hive.registerAdapter(DegreeAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.graduatedStudent)) {
      Hive.registerAdapter(GraduatedStudentAdapter());
    }

    if (!_isBoxOpen) {
      await _hiveService
          .openBox<GraduatedStudentModel>(LocalStorageKeys.graduatedStudent);
    }
  }
}
