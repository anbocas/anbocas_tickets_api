import 'package:anbocas_tickets_api/src/shared/anbocas_api_mode.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AnbocasTicketsConfig {
  AnbocasTicketsConfig._();

  static final instance = AnbocasTicketsConfig._();

  String? _apiKey;

  Dio? _dio;
  Dio get dio {
    assert(_dio != null, 'Anbocas SDK is not configured.');
    return _dio!;
  }

  void config({
    required String apiKey,
    bool enableLog = true,
    AnbocasApiMode mode = AnbocasApiMode.development,
  }) async {
    _apiKey = apiKey;
    _dio = Dio();
    _dio!.options = BaseOptions(baseUrl: _getBaseURL(mode));
    _dio!.interceptors.add(_tokenInterceptor());
    if (enableLog) {
      _dio!.interceptors.add(_logInterceptor());
    }

    if (kDebugMode) {
      print('Anbocas SDK is configured.');
    }
  }

  String _getBaseURL(AnbocasApiMode mode) {
    if (mode case AnbocasApiMode.sandbox) {
      return "https://sandbox-api.anbocas.com";
    } else if (mode case AnbocasApiMode.production) {
      return "https://api.anbocas.com";
    }
    // default development
    return "https://dev-api.anbocas.com";
  }

  Interceptor _tokenInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        assert(_apiKey != null, 'Anbocas SDK is not configured.');
        options.headers.addAll({"Authorization": "Bearer $_apiKey"});
        return handler.next(options);
      },
    );
  }

  Interceptor _logInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    );
  }
}
