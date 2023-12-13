import 'package:dio/dio.dart';

class DioClient {
  final _dio = Dio();

  Future<Response> get(
    String path,
  ) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> getId(
    String path,
    int id,
  ) async {
    try {
      final response = await _dio.get(path + id.toString());
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
