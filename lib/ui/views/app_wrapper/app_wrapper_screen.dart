import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/loader_view.dart';
import 'app_wrapper_view_model.dart';

@RoutePage()
class AppWrapperScreen extends StatelessWidget {
  const AppWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppWrapperViewModel>.reactive(
      viewModelBuilder: () => AppWrapperViewModel()..handleStartUpLogic(),
      builder: (context, model, child) {
        return PlatformScaffold(
          body: const Center(
            child: LoaderView(),
          ),
        );
      },
    );
  }
}
