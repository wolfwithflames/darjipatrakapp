import '../../../core/data/enums.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/models/deceased/deceased.dart';
import '../../../core/models/graduated_student_model/graduated_student_model.dart';
import '../../../core/repositories/graduated_students_repository/graduated_students_repository.dart';
import '../../../core/router/router.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';
import '../../widgets/toast.dart';

class GraduatedStudentsListViewModel extends AppBaseViewModel {
  final _deceasedRepository = getIt<GraduatedStudentsRepository>();
  final List<GraduatedStudentModel> _graduatedStudents = [];
  List<GraduatedStudentModel> get graduatedStudents => _graduatedStudents;

  /// Pagination
  int page = 1;
  bool hasNext = true;

  Future<void> onLoad() async {
    page++;
    await fetchGraduatedStudents(pageNo: page);
    refreshController.loadComplete();
  }

  @override
  Future<void> init() async {
    fetchGraduatedStudents();
  }

  fetchGraduatedStudents({
    int pageNo = 1,
    bool isRefresh = false,
  }) async {
    setViewState(ViewState.busy);
    try {
      final response =
          await _deceasedRepository.getGraduatedStudentList(page: pageNo);
      if (response.status) {
        if (isRefresh) {
          hasNext = true;
          page = 1;
          _graduatedStudents.clear();
        }
        _graduatedStudents.addAll(response.data);
        if (response.data.isEmpty) {
          hasNext = false;
        }
      } else {
        botToast(response.message);
      }
    } on RepositoryException catch (e) {
      AppLog.e(e.message);
      errorFetchingData = true;
    }

    setIdealState();
  }

  Future<void> onRefresh() async {
    await fetchGraduatedStudents(isRefresh: true);
    refreshController.refreshCompleted();
  }

  onDeceasedPressed(Deceased deceased) {
    getIt<AppRouter>().push(
      DeceasedDetailsRoute(id: deceased.id),
    );
  }
}
