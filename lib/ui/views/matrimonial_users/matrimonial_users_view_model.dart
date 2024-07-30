import '../../../core/data/enums.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/models/matrimonial_user/matrimonial_user.dart';
import '../../../core/repositories/matrimonial_user_repository/matrimonial_user_repository.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';
import '../../widgets/toast.dart';

class MatrimonialListViewModel extends AppBaseViewModel {
  final _matrimonialUserRepository = getIt<MatrimonialUsersRepository>();
  final List<MatrimonialUser> _matrimonialUsers = [];
  List<MatrimonialUser> get matrimonialUsers => _matrimonialUsers;

  /// Pagination
  int page = 1;
  bool hasNext = true;

  Future<void> onLoad() async {
    page++;
    await fetchMatrimonialUserList(pageNo: page);
    refreshController.loadComplete();
  }

  @override
  Future<void> init() async {
    fetchMatrimonialUserList();
  }

  fetchMatrimonialUserList({
    int pageNo = 1,
    bool isRefresh = false,
  }) async {
    setViewState(ViewState.busy);
    try {
      final response =
          await _matrimonialUserRepository.getMatrimonialUserList(page: pageNo);
      if (response.success) {
        AppLog.i(response.data);
        if (isRefresh) {
          hasNext = true;
          page = 1;
          _matrimonialUsers.clear();
        }
        _matrimonialUsers.addAll(response.data);
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
    await fetchMatrimonialUserList(isRefresh: true);
    refreshController.refreshCompleted();
  }

  onMatrimonialUserPressed(MatrimonialUser user) {
    // getIt<AppRouter>().push(
    //   MatrimonialUserDetailsRoute(
    //       id: user.id), // Replace with actual route and parameters
    // );
  }
}
