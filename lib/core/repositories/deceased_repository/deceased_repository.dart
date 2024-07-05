import '../../data/api_response.dart';
import '../../models/deceased/deceased.dart';

abstract class DeceasedRepository {
  Future<ApiResponse<List<Deceased>>> getDeceasedList({int page, int limit});
  Future<ApiResponse<Deceased>> getDeceasedDetails({required String id});
}
