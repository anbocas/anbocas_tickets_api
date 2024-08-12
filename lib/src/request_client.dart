import 'package:anbocas_tickets_api/src/anbocas_request_plugin.dart';
import 'package:anbocas_tickets_api/src/interceptor/api_log_interceptor.dart';
import 'package:anbocas_tickets_api/src/interceptor/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestClient {
  static RequestClient? _instance;
  final Dio _dio = Dio();

  Dio get dio => _dio;

  RequestClient._() {
    intConfig();
  }

  static RequestClient? get instance {
    _instance ??= RequestClient._();
    return _instance;
  }

  intConfig() {
    _dio.options = BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: AnbocasRequestPlugin.instance!.baseUrl,
      queryParameters: AnbocasRequestPlugin.instance!.defaultQueryParameters,
      connectTimeout: AnbocasRequestPlugin.instance!.connectTimeout,
      headers: AnbocasRequestPlugin.instance!.defaultHeaders,
    );
    if (!kReleaseMode && AnbocasRequestPlugin.instance!.enableLog) {
      addInterceptorOnce(ApiLogInterceptor());
    }

    _dio.options.headers
        .addAll({Headers.acceptHeader: Headers.jsonContentType});

    // add token interceptor
    if (AnbocasRequestPlugin.instance?.token != null) {
      addInterceptorOnce(TokenInterceptor());
    }
  }

  configAuth(bool authRequired) {
    bool hasInterceptor = _dio.interceptors.contains(TokenInterceptor());
    if (!authRequired && hasInterceptor) {
      _dio.interceptors.remove(TokenInterceptor());
    } else if (authRequired) {
      addInterceptorOnce(TokenInterceptor());
    }
  }

  addInterceptorOnce(Interceptor interceptor) {
    if (!_dio.interceptors.contains(interceptor)) {
      _dio.interceptors.add(interceptor);
    }
  }

  removeInterceptor(Interceptor interceptor) {
    if (_dio.interceptors.contains(interceptor)) {
      _dio.interceptors.remove(interceptor);
    }
  }

  static refreshConfig() {
    print('Refresh');
    _instance = RequestClient._();
  }
}
