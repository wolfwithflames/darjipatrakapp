import '../../../core/data/enums.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/models/deceased/deceased.dart';
import '../../../core/repositories/deceased_repository/deceased_repository.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';
import '../../widgets/toast.dart';

class DeceasedListViewModel extends AppBaseViewModel {
  final _deceasedRepository = getIt<DeceasedRepository>();
  final List<Deceased> _deceased = [];
  List<Deceased> get deceased => _deceased;

  /// Pagination
  int page = 1;
  bool hasNext = true;

  bool _errorFetchingUser = false;
  bool get errorFetchingUser => _errorFetchingUser;

  Future<void> onLoad() async {
    page++;
    await fetchDeceasedList(pageNo: page);
    refreshController.loadComplete();
  }

  @override
  Future<void> init() async {
    fetchDeceasedList();
  }

  fetchDeceasedList({
    int pageNo = 1,
    bool isRefresh = false,
  }) async {
    setViewState(ViewState.busy);
    try {
      final response = await _deceasedRepository.getDeceased(page: pageNo);
      if (response.status) {
        if (isRefresh) {
          hasNext = true;
          page = 1;
          _deceased.clear();
        }
        _deceased.addAll(response.data);
        if (response.data.isEmpty) {
          hasNext = false;
        }
      } else {
        botToast(response.message);
      }
    } on RepositoryException catch (e) {
      AppLog.e(e.message);
      _errorFetchingUser = true;
    }

    setIdealState();
  }

  Future<void> onRefresh() async {
    await fetchDeceasedList(isRefresh: true);
    refreshController.refreshCompleted();
  }

  onDeceasedPressed(Deceased p1) {}
}
