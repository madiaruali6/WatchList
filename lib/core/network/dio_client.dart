import 'package:dio/dio.dart';
import '../config/api_config.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.tmdbBaseUrl,
        queryParameters: {'api_key': ApiConfig.tmdbApiKey, 'language': 'ru-RU'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );

    return dio;
  }
}
