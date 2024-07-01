import '../../../getIt.dart';
import '../../constants/api_routes.dart';
import '../../constants/constants.dart';
import '../../data/api_response.dart';
import '../../logger/app_logger.dart';
import '../../models/deceased/deceased.dart';
import '../../services/http/http_service.dart';

abstract class DeceasedRemoteDataSource {
  Future<ApiResponse<List<Deceased>>> fetchDeceased({int page, int limit});
}

class DeceasedRemoteDataSourceImpl implements DeceasedRemoteDataSource {
  final httpService = getIt<HttpService>();

  @override
  Future<ApiResponse<List<Deceased>>> fetchDeceased({
    int page = 1,
    int limit = Constants.paginationLimit,
  }) async {
    final postsMap =
        await httpService.getHttp(ApiRoutes.deceased, queryParameters: {
      "page": page,
      "limit": limit,
    }) as Map<String, dynamic>;
    AppLog.prettyPrint(postsMap);

    return ApiResponse.fromJson(postsMap,
        (data) => (data as List).map((e) => Deceased.fromJson(e)).toList());
  }
}
