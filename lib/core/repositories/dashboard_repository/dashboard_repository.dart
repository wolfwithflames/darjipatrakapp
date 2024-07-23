import '../../data/api_response.dart';
import '../../models/dashboard/dashboard.dart';

abstract class DashboardRepository {
  Future<ApiResponse<DashboardModel>> getDashboard();
}
