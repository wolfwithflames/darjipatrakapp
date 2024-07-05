import 'package:auto_route/auto_route.dart';

import '../../ui/views/app_navigator/app_navigator.dart';
import '../../ui/views/app_wrapper/app_wrapper_screen.dart';
import '../../ui/views/auth/auth_screen.dart';
import '../../ui/views/deceased_details/deceased_details_screen.dart';
import '../../ui/views/deceased_list/deceased_list_screen.dart';
import '../../ui/views/register/register_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: Routes.root,
          page: AppWrapperRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: Routes.auth,
              page: AuthRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: Routes.deceasedList,
          page: DeceasedListRoute.page,
        ),
        AutoRoute(
          path: Routes.deceasedDetails,
          page: DeceasedDetailsRoute.page,
        ),
      ];
}

class Routes {
  static const String root = "/";
  static const String appNav = "home";
  static const String auth = "auth";
  static const String register = "register";
  static const String deceasedList = "/deceasedList";
  static const String deceasedDetails = "/deceasedDetails";
}
