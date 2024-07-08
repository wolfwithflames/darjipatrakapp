import 'package:stacked/stacked.dart';

import '../../../core/data_sources/deceased/deceased_local_data_source.dart';
import '../../../core/data_sources/graduated_students/graduated_students_local_data_source.dart';
import '../../../core/router/router.dart';
import '../../../core/services/hardware_info/hardware_info_service.dart';
import '../../../getIt.dart';

class AppWrapperViewModel extends BaseViewModel {
  final deceasedLocalDataSource = getIt<DeceasedLocalDataSource>();
  final graduatedStudentsLocalDataSource =
      getIt<GraduatedStudentsLocalDataSource>();

  final hardwareInfoService = getIt<HardwareInfoService>();

  handleStartUpLogic() async {
    await Future.wait([
      deceasedLocalDataSource.init(),
      graduatedStudentsLocalDataSource.init(),
      hardwareInfoService.init(),
    ]);
    await Future.delayed(const Duration(seconds: 3), () {
      getIt<AppRouter>().replaceNamed(Routes.graduatedList);
    });
  }
}
