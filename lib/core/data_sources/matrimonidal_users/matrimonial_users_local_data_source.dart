import 'package:hive/hive.dart';

import '../../../getIt.dart';
import '../../constants/local_storage_keys.dart';
import '../../exceptions/cache_exception.dart';
import '../../hive_helper/hive_types.dart';
import '../../models/deceased/name.dart';
import '../../models/matrimonial_user/address.dart';
import '../../models/matrimonial_user/contact_info.dart';
import '../../models/matrimonial_user/matrimonial_user.dart';
import '../../utils/file_helper.dart';

abstract class MatrimonialUsersLocalDataSource {
  Future<void> init();

  Future<List<MatrimonialUser>> fetchMatrimonialUsers();

  Future<void> cacheMatrimonialUsers(List<MatrimonialUser> matrimonialUsers);
}

class MatrimonialUsersLocalDataSourceImpl
    implements MatrimonialUsersLocalDataSource {
  final _fileHelper = getIt<FileHelper>();
  final _hiveService = getIt<HiveInterface>();

  bool get _isBoxOpen =>
      _hiveService.isBoxOpen(LocalStorageKeys.matrimonialUser);
  Box<MatrimonialUser> get _usersBox =>
      _hiveService.box<MatrimonialUser>(LocalStorageKeys.matrimonialUser);

  @override
  Future<void> cacheMatrimonialUsers(
      List<MatrimonialUser> matrimonialUsers) async {
    final usersMap = <String, MatrimonialUser>{};
    for (var user in matrimonialUsers) {
      usersMap.addAll({user.id ?? '': user});
    }

    await _usersBox.putAll(usersMap);
  }

  @override
  Future<List<MatrimonialUser>> fetchMatrimonialUsers() async {
    if (_usersBox.isEmpty) {
      throw const CacheException('No MatrimonialUsers found in cache');
    }

    return _usersBox.values
        .map<MatrimonialUser>(
          (user) => MatrimonialUser.fromJson(user.toJson()),
        )
        .toList();
  }

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    if (!Hive.isAdapterRegistered(HiveTypes.name)) {
      Hive.registerAdapter(NameAdapter());
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
      await _hiveService
          .openBox<MatrimonialUser>(LocalStorageKeys.matrimonialUser);
    }
  }
}
