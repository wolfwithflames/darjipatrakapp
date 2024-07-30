import 'dart:async';

import '../../../getIt.dart';
import '../../constants/constants.dart';
import '../../data/api_response.dart';
import '../../data_sources/graduated_students/graduated_students_local_data_source.dart';
import '../../data_sources/graduated_students/graduated_students_remote_data_source.dart';
import '../../exceptions/cache_exception.dart';
import '../../exceptions/network_exception.dart';
import '../../exceptions/repository_exception.dart';
import '../../models/graduated_student_model/graduated_student_model.dart';
import '../../services/connectivity/connectivity_service.dart';
import 'graduated_students_repository.dart';

class GraduatedStudentsRepositoryImpl implements GraduatedStudentsRepository {
  final remoteDataSource = getIt<GraduatedStudentsRemoteDataSource>();
  final localDataSource = getIt<GraduatedStudentsLocalDataSource>();
  final connectivityService = getIt<ConnectivityService>();

  @override
  Future<ApiResponse<List<GraduatedStudentModel>>> getGraduatedStudentList(
      {int page = 1, int limit = Constants.paginationLimit}) async {
    try {
      if (await connectivityService.isConnected) {
        final posts = await remoteDataSource.fetchGraduatedStudents(
          page: page,
          limit: limit,
        );
        await localDataSource.cacheGraduatedStudentModels(posts.data);
        return posts;
      } else {
        final posts = await localDataSource.fetchGraduatedStudents();

        return ApiResponse<List<GraduatedStudentModel>>(
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
  Future<ApiResponse<GraduatedStudentModel>> getGraduatedStudentDetails(
      {required String id}) async {
    try {
      // if (await connectivityService.isConnected) {
      final post = await remoteDataSource.fetchGraduatedStudentDetails(
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
