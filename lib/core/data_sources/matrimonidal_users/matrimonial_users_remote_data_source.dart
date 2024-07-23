import '../../../getIt.dart';
import '../../constants/api_routes.dart';
import '../../constants/constants.dart';
import '../../data/api_response.dart';
import '../../logger/app_logger.dart';
import '../../models/matrimonial_user/matrimonial_user.dart';
import '../../services/http/http_service.dart';

abstract class MatrimonialUsersRemoteDataSource {
  Future<ApiResponse<List<MatrimonialUser>>> fetchMatrimonialUsers(
      {int page, int limit});
  Future<ApiResponse<MatrimonialUser>> fetchMatrimonialUserDetails(
      {required String id});
}

class MatrimonialUsersRemoteDataSourceImpl
    implements MatrimonialUsersRemoteDataSource {
  final httpService = getIt<HttpService>(); // Adjust as per your service setup

  @override
  Future<ApiResponse<List<MatrimonialUser>>> fetchMatrimonialUsers({
    int page = 1,
    int limit = Constants.paginationLimit,
  }) async {
    final response =
        await httpService.getHttp(ApiRoutes.matrimonialUsers, queryParameters: {
      "page": page,
      "limit": limit,
    }) as Map<String, dynamic>;
    AppLog.prettyPrint(response);

    return ApiResponse.fromJson(
      response,
      (data) => (data as List).map((e) => MatrimonialUser.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<MatrimonialUser>> fetchMatrimonialUserDetails({
    required String id,
  }) async {
    final response = await httpService
        .getHttp('${ApiRoutes.matrimonialUsers}/$id') as Map<String, dynamic>;
    AppLog.prettyPrint(response);

    return ApiResponse.fromJson(
      response,
      (data) => MatrimonialUser.fromJson(data),
    );
  }
}
