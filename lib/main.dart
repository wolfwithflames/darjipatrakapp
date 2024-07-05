import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'getIt.dart';
import 'patrika_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize localization
  await EasyLocalization.ensureInitialized();

  /// Initialize getIt
  await initGetit();

  // registerAdapters();

  /// Initializes the Firebase app with the provided options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initializes the GetStorage library. For local preferences storage.
  await GetStorage.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('gu', 'IN')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('gu', 'IN'),
      child: DevicePreview(
        enabled: false,
        builder: (context) {
          return const MyApp();
        },
      ),
    ),
  );
}
