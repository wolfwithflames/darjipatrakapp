import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/router/router.dart';
import 'getIt.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates, // <-- add this
      supportedLocales: context.supportedLocales, // <-- add this
      locale: context.locale, // <-- add this
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<AppRouter>().config(),
      builder: BotToastInit(),
    );
  }
}
