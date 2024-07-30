import '../../../core/exceptions/repository_exception.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/models/deceased/deceased.dart';
import '../../../core/repositories/deceased_repository/deceased_repository.dart';
import '../../../getIt.dart';
import '../../view_model/app_base_model.dart';
import '../../widgets/toast.dart';

class DeceasedDetailsViewModel extends AppBaseViewModel {
  final String deceasedId;

  DeceasedDetailsViewModel({
    required this.deceasedId,
  });

  final _deceasedRepository = getIt<DeceasedRepository>();

  Deceased? _deceased;
  Deceased? get deceased => _deceased;

  @override
  Future<void> init() async {
    fetchDeceasedDetails();
  }

  Future<void> fetchDeceasedDetails() async {
    try {
      final response =
          await _deceasedRepository.getDeceasedDetails(id: deceasedId);
      if (response.success) {
        _deceased = response.data;
      } else {
        botToast(response.message);
      }
    } on RepositoryException catch (e) {
      AppLog.e(e.message);
      errorFetchingData = true;
    }

    setSuccessApiResponseState();
  }
}
