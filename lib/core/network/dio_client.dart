import 'package:dio/dio.dart';
import '../config/api_config.dart';

/// Единая точка создания Dio-клиента для всего приложения.
/// Если завтра понадобится добавить общий interceptor (логирование,
/// токен авторизации и т.д.) — меняем в одном месте.
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

    // Полезно на этапе разработки — видно все запросы в консоли
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );

    return dio;
  }
}
