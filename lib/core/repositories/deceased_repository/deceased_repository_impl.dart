import 'dart:async';

import '../../../getIt.dart';
import '../../constants/constants.dart';
import '../../data/api_response.dart';
import '../../data_sources/deceased/deceased_local_data_source.dart';
import '../../data_sources/deceased/deceased_remote_data_source.dart';
import '../../exceptions/cache_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/deceased/deceased.dart';
import '../../services/connectivity/connectivity_service.dart';
import 'deceased_repository.dart';

class DeceasedRepositoryImpl implements DeceasedRepository {
  final remoteDataSource = getIt<DeceasedRemoteDataSource>();
  final localDataSource = getIt<DeceasedLocalDataSource>();
  final connectivityService = getIt<ConnectivityService>();

  @override
  Future<ApiResponse<List<Deceased>>> getDeceasedList(
      {int page = 1, int limit = Constants.paginationLimit}) async {
    try {
      if (await connectivityService.isConnected) {
        final posts = await remoteDataSource.fetchDeceased(
          page: page,
          limit: limit,
        );
        await localDataSource.cacheDeceaseds(posts.data);
        return posts;
      } else {
        final posts = await localDataSource.fetchDeceased();
        return ApiResponse<List<Deceased>>(
          success: true,
          data: posts,
        );
      }
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<ApiResponse<Deceased>> getDeceasedDetails({required String id}) async {
    try {
      // if (await connectivityService.isConnected) {
      final post = await remoteDataSource.fetchDeceasedDetails(
        id: id,
      );
      // await localDataSource.cacheDeceaseds(posts.data);
      return post;
      // } else {
      //   final posts = await localDataSource.fetchDeceased();
      //   return ApiResponse<List<Deceased>>(
      //     status: true,
      //     data: posts,
      //   );
      // }
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
