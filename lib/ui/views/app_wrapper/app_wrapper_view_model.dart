import 'package:stacked/stacked.dart';

import '../../../core/data_sources/deceased/deceased_local_data_source.dart';
import '../../../core/router/router.dart';
import '../../../core/services/hardware_info/hardware_info_service.dart';
import '../../../getIt.dart';

class AppWrapperViewModel extends BaseViewModel {
  final deceasedLocalDataSource = getIt<DeceasedLocalDataSource>();

  final hardwareInfoService = getIt<HardwareInfoService>();

  handleStartUpLogic() async {
    await Future.wait([
      deceasedLocalDataSource.init(),
      hardwareInfoService.init(),
    ]);
    await Future.delayed(const Duration(seconds: 3), () {
      getIt<AppRouter>().navigateNamed(Routes.deceased);
    });
  }
}
