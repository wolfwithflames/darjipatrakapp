import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/router/router.dart';
import 'app_wrapper_view_model.dart';

@RoutePage()
class AppWrapperScreen extends StatelessWidget {
  const AppWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppWrapperViewModel>.reactive(
      viewModelBuilder: () => AppWrapperViewModel(),
      builder: (context, model, child) {
        return AutoTabsScaffold(
          routes: const [
            DashboardRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab 1'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Tab 2'),
              ],
            );
          },
        );
      },
    );
  }
}
