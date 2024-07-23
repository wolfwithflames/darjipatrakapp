import '../../data/api_response.dart';
import '../../models/matrimonial_user/matrimonial_user.dart';

abstract class MatrimonialUsersRepository {
  Future<ApiResponse<List<MatrimonialUser>>> getMatrimonialUserList(
      {int page, int limit});

  Future<ApiResponse<MatrimonialUser>> getMatrimonialUserDetails(
      {required String id});
}
