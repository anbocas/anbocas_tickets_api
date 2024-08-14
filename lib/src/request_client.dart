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
      baseUrl: AnbocasTicketsApi.instance!.baseUrl,
      queryParameters: AnbocasTicketsApi.instance!.defaultQueryParameters,
      connectTimeout: AnbocasTicketsApi.instance!.connectTimeout,
      headers: AnbocasTicketsApi.instance!.defaultHeaders,
    );
    if (!kReleaseMode && AnbocasTicketsApi.instance!.enableLog) {
      addInterceptorOnce(ApiLogInterceptor());
    }

    _dio.options.headers
        .addAll({Headers.acceptHeader: Headers.jsonContentType});

    // add token interceptor
    if (AnbocasTicketsApi.instance?.token != null) {
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
    debugPrint('Refresh');
    _instance = RequestClient._();
  }
}
