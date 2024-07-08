import '../../../getIt.dart';
import '../../constants/api_routes.dart';
import '../../constants/constants.dart';
import '../../data/api_response.dart';
import '../../logger/app_logger.dart';
import '../../models/graduated_student_model/graduated_student_model.dart';
import '../../services/http/http_service.dart';

abstract class GraduatedStudentsRemoteDataSource {
  Future<ApiResponse<List<GraduatedStudentModel>>> fetchGraduatedStudents(
      {int page, int limit});
  Future<ApiResponse<GraduatedStudentModel>> fetchGraduatedStudentDetails(
      {required String id});
}

class GraduatedStudentsRemoteDataSourceImpl
    implements GraduatedStudentsRemoteDataSource {
  final httpService = getIt<HttpService>();

  @override
  Future<ApiResponse<List<GraduatedStudentModel>>> fetchGraduatedStudents({
    int page = 1,
    int limit = Constants.paginationLimit,
  }) async {
    final postsMap =
        await httpService.getHttp(ApiRoutes.students, queryParameters: {
      "page": page,
      "limit": limit,
    }) as Map<String, dynamic>;
    AppLog.prettyPrint(postsMap);

    return ApiResponse.fromJson(
      postsMap,
      (data) =>
          (data as List).map((e) => GraduatedStudentModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<ApiResponse<GraduatedStudentModel>> fetchGraduatedStudentDetails(
      {required String id}) {
    // TODO: implement fetchDetails
    throw UnimplementedError();
  }
}
