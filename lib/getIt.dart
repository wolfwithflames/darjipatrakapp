import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/data_sources/deceased/deceased_local_data_source.dart';
import 'core/data_sources/deceased/deceased_remote_data_source.dart';
import 'core/data_sources/graduated_students/graduated_students_local_data_source.dart';
import 'core/data_sources/graduated_students/graduated_students_remote_data_source.dart';
import 'core/data_sources/story/story_remote_data_source.dart';
import 'core/data_sources/users/users_remote_data_source.dart';
import 'core/repositories/deceased_repository/deceased_repository.dart';
import 'core/repositories/deceased_repository/deceased_repository_impl.dart';
import 'core/repositories/graduated_students_repository/graduated_students_repository.dart';
import 'core/repositories/graduated_students_repository/graduated_students_repository_impl.dart';
import 'core/repositories/story_repository/story_repository.dart';
import 'core/repositories/story_repository/story_repository_impl.dart';
import 'core/repositories/users_repository/users_repository.dart';
import 'core/repositories/users_repository/users_repository_impl.dart';
import 'core/router/router.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/connectivity/connectivity_service_impl.dart';
import 'core/services/hardware_info/hardware_info_service.dart';
import 'core/services/hardware_info/hardware_info_service_impl.dart';
import 'core/services/http/http_service.dart';
import 'core/services/http/http_service_impl.dart';
import 'core/utils/file_helper.dart';
import 'core/utils/image_compress_utils.dart';
import 'core/utils/sharing_intents.dart';

GetIt getIt = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> initGetit() async {
  // App Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Services
  getIt.registerLazySingleton<HardwareInfoService>(
    () => HardwareInfoServiceImpl(),
  );
  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  getIt.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  getIt.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl());
  getIt.registerLazySingleton<DeceasedRemoteDataSource>(
      () => DeceasedRemoteDataSourceImpl());
  getIt.registerLazySingleton<DeceasedLocalDataSource>(
      () => DeceasedLocalDataSourceImpl());
  getIt.registerLazySingleton<GraduatedStudentsLocalDataSource>(
      () => GraduatedStudentsLocalDataSourceImpl());
  getIt.registerLazySingleton<GraduatedStudentsRemoteDataSource>(
      () => GraduatedStudentsRemoteDataSourceImpl());
  getIt.registerLazySingleton<StoryRemoteDataSource>(
      () => StoryRemoteDataSourceImpl());

  /// Repositories
  getIt.registerLazySingleton<DeceasedRepository>(
      () => DeceasedRepositoryImpl());
  getIt.registerLazySingleton<GraduatedStudentsRepository>(
      () => GraduatedStudentsRepositoryImpl());
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());
  getIt.registerLazySingleton<StoryRepository>(() => StoryRepositoryImpl());

  // Utils
  getIt.registerLazySingleton<FileHelper>(() => FileHelperImpl());
  getIt.registerLazySingleton<ImageCompressHelper>(
      () => ImageCompressHelperImpl());
  getIt.registerLazySingleton<SharingIntent>(() => SharingIntent());

  // External
  getIt.registerLazySingleton<HiveInterface>(() => Hive);
}
