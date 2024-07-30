import '../../../core/data/enums.dart';
import '../../../core/data_sources/dashboard/dashboard_local_data_source.dart';
import '../../../core/models/dashboard/dashboard.dart';
import '../../../core/models/deceased/deceased.dart';
import '../../../core/models/graduated_student_model/graduated_student_model.dart';
import '../../../core/models/matrimonial_user/matrimonial_user.dart';
import '../../../core/repositories/dashboard_repository/dashboard_repository.dart';
import '../../../core/router/router.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';
import '../../widgets/toast.dart';

class DashboardViewModel extends AppBaseViewModel {
  final _dashboardRepository = getIt<DashboardRepository>();
  final _dashboardLocalDataSource = getIt<DashboardLocalDataSource>();
  DashboardModel? dashboardModel;

  @override
  init() async {
    await _dashboardLocalDataSource.init();
    final response = await _dashboardRepository.getDashboard();
    if (response.success) {
      setApiResponseStatus(ApiResponseStatus.success);
      dashboardModel = response.data;
    } else {
      setApiResponseStatus(ApiResponseStatus.error);
      botToast(response.message);
    }
  }

  List<MatrimonialUser> get matrimonialUsers =>
      dashboardModel?.matrimonialUsers ?? [];
  List<Deceased> get deceasedUsers => dashboardModel?.deceased ?? [];
  List<GraduatedStudentModel> get students => dashboardModel?.students ?? [];

  void onMatrimonialViewMoreTap() {
    getIt<AppRouter>().pushNamed(Routes.matrimonialList);
  }

  void onDeceasedViewMoreTap() {
    getIt<AppRouter>().pushNamed(Routes.deceasedList);
  }

  void onStudentsViewMoreTap() {
    getIt<AppRouter>().pushNamed(Routes.graduatedList);
  }
}
