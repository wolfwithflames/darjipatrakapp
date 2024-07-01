import '../../data/api_response.dart';
import '../../models/deceased/deceased.dart';

abstract class DeceasedRepository {
  Future<ApiResponse<List<Deceased>>> getDeceased({int page, int limit});
}
