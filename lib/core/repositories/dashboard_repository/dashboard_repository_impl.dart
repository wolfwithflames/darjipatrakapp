import "../../../getIt.dart";
import "../../data/api_response.dart";
import "../../data_sources/dashboard/dashboard_local_data_source.dart";
import "../../data_sources/dashboard/dashboard_remote_data_source.dart";
import "../../exceptions/cache_exception.dart";
import "../../exceptions/network_exception.dart";
import "../../exceptions/repository_exception.dart";
import "../../models/dashboard/dashboard.dart";
import "../../services/connectivity/connectivity_service.dart";
import "dashboard_repository.dart";

class DashboardRepositoryImpl implements DashboardRepository {
  final remoteDataSource = getIt<DashboardRemoteDataSource>();
  final localDataSource = getIt<DashboardLocalDataSource>();
  final connectivityService = getIt<ConnectivityService>();

  @override
  Future<ApiResponse<DashboardModel>> getDashboard() async {
    try {
      if (await connectivityService.isConnected) {
        final users = await remoteDataSource.fetchDashboard();
        await localDataSource.cacheDashboardModel(users.data);
        return users;
      } else {
        final users = await localDataSource.fetchDashboard();

        return ApiResponse<DashboardModel>(
          success: true,
          data: users,
        );
      }
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
