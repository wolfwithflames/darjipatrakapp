import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../getIt.dart';
import '../../exceptions/network_exception.dart';
import '../../utils/file_helper.dart';
import '../../utils/network_utils.dart' as network_utils;
import '../../utils/pref_utils.dart';
import 'http_service.dart';

/// Helper service that abstracts away common HTTP Requests
class HttpServiceImpl implements HttpService {
  final _fileHelper = getIt<FileHelper>();

  final _log = Logger('HttpServiceImpl');
  final _dio = Dio();

  @override
  Future<dynamic> getHttp(
    String route, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    _log.fine('Sending GET to $route');

    try {
      final fullRoute = route;
      String? authToken = PrefsUtils.getAuthToken();
      if (authToken != null) {
        _dio.options.headers.addAll({
          "Authorization": "Bearer $authToken",
        });
      }
      response = await _dio.get(
        fullRoute,
        queryParameters: queryParameters,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioException catch (e) {
      _log.severe('HttpService: Failed to GET ${e.message}');
      throw NetworkException(e.message ?? "Something went wrong");
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttp(String route, dynamic body) async {
    Response response;

    _log.fine('Sending $body to $route');

    try {
      final fullRoute = route;
      String? authToken = PrefsUtils.getAuthToken();
      if (authToken != null) {
        _dio.options.headers.addAll({
          "Authorization": "Bearer $authToken",
        });
      }

      response = await _dio.post(
        fullRoute,
        data: body,
        onSendProgress: network_utils.showLoadingProgress,
        onReceiveProgress: network_utils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } on DioException catch (e) {
      _log.severe('HttpService: Failed to POST ${e.message}');
      throw NetworkException(e.message ?? "Something went wrong");
    }

    network_utils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  @override
  Future<dynamic> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    var index = 0;

    final formData = FormData.fromMap(body);
    files.forEach((file) async {
      final mFile = await _fileHelper.convertFileToMultipartFile(file);
      formData.files.add(MapEntry('file$index', mFile));
      index++;
    });

    final data = await postHttp(route, formData);

    return data;
  }

  @override
  Future<File> downloadFile(String fileUrl) async {
    Response response;

    final file = await _fileHelper.getFileFromUrl(fileUrl);

    try {
      response = await _dio.download(
        fileUrl,
        file.path,
        onReceiveProgress: network_utils.showLoadingProgress,
      );
    } on DioException catch (e) {
      _log.severe('HttpService: Failed to download file ${e.message}');
      throw NetworkException(e.message ?? "Something went wrong");
    }

    network_utils.checkForNetworkExceptions(response);

    return file;
  }

  @override
  void dispose() {
    _dio.close(force: true);
  }
}
