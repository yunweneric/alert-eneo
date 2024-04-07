import 'package:dio/dio.dart';

abstract class BaseService {
  final Dio _dio;

  BaseService({required Dio dio}) : _dio = dio;

  Future<Response> get(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post({
    required String url,
    required Object? data,
  }) async {
    return await _dio.post(url, data: data);
  }
}
