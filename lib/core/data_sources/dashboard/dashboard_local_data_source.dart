import 'package:hive/hive.dart';

import '../../../getIt.dart';
import '../../constants/local_storage_keys.dart';
import '../../exceptions/cache_exception.dart';
import '../../hive_helper/hive_types.dart';
import '../../models/dashboard/dashboard.dart';
import '../../models/deceased/deceased.dart';
import '../../models/deceased/name.dart';
import '../../models/deceased/relative.dart';
import '../../models/degree/degree.dart';
import '../../models/graduated_student_model/graduated_student_model.dart';
import '../../models/matrimonial_user/address.dart';
import '../../models/matrimonial_user/contact_info.dart';
import '../../models/matrimonial_user/matrimonial_user.dart';
import '../../utils/file_helper.dart';

abstract class DashboardLocalDataSource {
  Future<void> init();

  Future<DashboardModel> fetchDashboard();

  Future<void> cacheDashboardModel(DashboardModel dashboardModel);
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final _fileHelper = getIt<FileHelper>();
  final _hiveService = getIt<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(LocalStorageKeys.dashboard);
  Box<DashboardModel> get _usersBox =>
      _hiveService.box<DashboardModel>(LocalStorageKeys.dashboard);

  @override
  Future<void> cacheDashboardModel(DashboardModel dashboardModel) async {
    await _usersBox.putAll(
        {DateTime.now().millisecondsSinceEpoch.toString(): dashboardModel});
  }

  @override
  Future<DashboardModel> fetchDashboard() async {
    if (_usersBox.isEmpty) {
      throw const CacheException('No MatrimonialUsers found in cache');
    }

    return DashboardModel.fromJson(_usersBox.values.first.toJson());
  }

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    if (!Hive.isAdapterRegistered(HiveTypes.dashboard)) {
      Hive.registerAdapter(DashboardAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.name)) {
      Hive.registerAdapter(NameAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.deceased)) {
      Hive.registerAdapter(DeceasedAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.relative)) {
      Hive.registerAdapter(RelativeAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.graduatedStudent)) {
      Hive.registerAdapter(GraduatedStudentAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.degree)) {
      Hive.registerAdapter(DegreeAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.address)) {
      Hive.registerAdapter(AddressAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.contactInfo)) {
      Hive.registerAdapter(ContactInfoAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.matrimonialUser)) {
      Hive.registerAdapter(MatrimonialUserAdapter());
    }

    if (!_isBoxOpen) {
      await _hiveService.openBox<DashboardModel>(LocalStorageKeys.dashboard);
    }
  }
}
