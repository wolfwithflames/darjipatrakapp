import '../../../getIt.dart';
import '../../constants/api_routes.dart';
import '../../data/api_response.dart';
import '../../logger/app_logger.dart';
import '../../models/dashboard/dashboard.dart';
import '../../services/http/http_service.dart';

abstract class DashboardRemoteDataSource {
  Future<ApiResponse<DashboardModel>> fetchDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final httpService = getIt<HttpService>(); // Adjust as per your service setup

  @override
  Future<ApiResponse<DashboardModel>> fetchDashboard() async {
    final response =
        await httpService.getHttp(ApiRoutes.dashboard) as Map<String, dynamic>;
    AppLog.prettyPrint(response);
    return ApiResponse.fromJson(
      response,
      (data) => DashboardModel.fromJson(data),
    );
  }
}
