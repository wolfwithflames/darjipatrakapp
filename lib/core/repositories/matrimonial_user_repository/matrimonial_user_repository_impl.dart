import "../../../getIt.dart";
import "../../constants/constants.dart";
import "../../data/api_response.dart";
import "../../data_sources/matrimonidal_users/matrimonial_users_local_data_source.dart";
import "../../data_sources/matrimonidal_users/matrimonial_users_remote_data_source.dart";
import "../../exceptions/cache_exception.dart";
import "../../exceptions/network_exception.dart";
import "../../exceptions/repository_exception.dart";
import "../../models/matrimonial_user/matrimonial_user.dart";
import "../../services/connectivity/connectivity_service.dart";
import "matrimonial_user_repository.dart";

class MatrimonialUsersRepositoryImpl implements MatrimonialUsersRepository {
  final remoteDataSource = getIt<MatrimonialUsersRemoteDataSource>();
  final localDataSource = getIt<MatrimonialUsersLocalDataSource>();
  final connectivityService = getIt<ConnectivityService>();

  @override
  Future<ApiResponse<List<MatrimonialUser>>> getMatrimonialUserList(
      {int page = 1, int limit = Constants.paginationLimit}) async {
    try {
      if (await connectivityService.isConnected) {
        final users = await remoteDataSource.fetchMatrimonialUsers(
          page: page,
          limit: limit,
        );
        await localDataSource.cacheMatrimonialUsers(users.data);
        return users;
      } else {
        final users = await localDataSource.fetchMatrimonialUsers();

        return ApiResponse<List<MatrimonialUser>>(
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

  @override
  Future<ApiResponse<MatrimonialUser>> getMatrimonialUserDetails(
      {required String id}) async {
    try {
      final user = await remoteDataSource.fetchMatrimonialUserDetails(
        id: id,
      );
      return user;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
