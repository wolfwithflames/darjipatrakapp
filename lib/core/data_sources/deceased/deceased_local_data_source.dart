import 'package:hive/hive.dart';

import '../../../getIt.dart';
import '../../constants/local_storage_keys.dart';
import '../../exceptions/cache_exception.dart';
import '../../hive_helper/hive_types.dart';
import '../../models/deceased/deceased.dart';
import '../../models/deceased/name.dart';
import '../../models/deceased/relative.dart';
import '../../utils/file_helper.dart';

abstract class DeceasedLocalDataSource {
  Future<void> init();

  Future<List<Deceased>> fetchDeceased();

  Future<void> cacheDeceaseds(List<Deceased> deceased);
}

class DeceasedLocalDataSourceImpl implements DeceasedLocalDataSource {
  final _fileHelper = getIt<FileHelper>();
  final _hiveService = getIt<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(LocalStorageKeys.deceased);
  Box<Deceased> get _deceasedBox =>
      _hiveService.box<Deceased>(LocalStorageKeys.deceased);

  @override
  Future<void> init() async {
    final path = await _fileHelper.getApplicationDocumentsDirectoryPath();
    _hiveService.init(path);
    if (!Hive.isAdapterRegistered(HiveTypes.name)) {
      Hive.registerAdapter(NameAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.relative)) {
      Hive.registerAdapter(RelativeAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypes.deceased)) {
      Hive.registerAdapter(DeceasedAdapter());
    }

    if (!_isBoxOpen) {
      await _hiveService.openBox<Deceased>(LocalStorageKeys.deceased);
    }
  }

  @override
  Future<List<Deceased>> fetchDeceased() async {
    if (_deceasedBox.isEmpty) {
      throw const CacheException('No Deceased found in cache');
    }

    return _deceasedBox.values
        .map<Deceased>(
          (deceased) => Deceased.fromJson(deceased.toJson()),
        )
        .toList();
  }

  @override
  Future<void> cacheDeceaseds(List<Deceased> deceaseds) async {
    final deceasedMap = <String, Deceased>{};
    for (var decease in deceaseds) {
      deceasedMap.addAll({decease.id: decease});
    }

    await _deceasedBox.putAll(deceasedMap);
  }
}
