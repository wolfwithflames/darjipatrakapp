import 'package:hive/hive.dart';

import '../models/deceased/deceased.dart';
import '../models/deceased/name.dart';
import '../models/deceased/relative.dart';
import 'hive_types.dart';

void registerAdapters() {
  if (!Hive.isAdapterRegistered(HiveTypes.deceased)) {
    Hive.registerAdapter(DeceasedAdapter());
  }
  if (!Hive.isAdapterRegistered(HiveTypes.name)) {
    Hive.registerAdapter(NameAdapter());
  }
  if (!Hive.isAdapterRegistered(HiveTypes.relative)) {
    Hive.registerAdapter(RelativeAdapter());
  }
}
