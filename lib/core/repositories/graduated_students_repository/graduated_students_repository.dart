import '../../data/api_response.dart';
import '../../models/graduated_student_model/graduated_student_model.dart';

abstract class GraduatedStudentsRepository {
  Future<ApiResponse<List<GraduatedStudentModel>>> getGraduatedStudentList(
      {int page, int limit});
  Future<ApiResponse<GraduatedStudentModel>> getGraduatedStudentDetails(
      {required String id});
}
