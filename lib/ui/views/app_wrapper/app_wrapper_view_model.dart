import '../../../core/data_sources/dashboard/dashboard_local_data_source.dart';
import '../../../core/repositories/dashboard_repository/dashboard_repository.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';

class AppWrapperViewModel extends AppBaseViewModel {
  final _dashboardRepository = getIt<DashboardRepository>();
  final _dashboardLocalDataSource = getIt<DashboardLocalDataSource>();

  handleStartUpLogic() async {
    await _dashboardLocalDataSource.init();
    final response = await _dashboardRepository.getDashboard();
    print(response);
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Future.delayed(const Duration(seconds: 3), () {
    //     getIt<AppRouter>().replaceNamed(Routes.matrimonialList);
    //   });
    // });
  }
}
