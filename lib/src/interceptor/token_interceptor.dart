import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final String _tag = 'token';
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = AnbocasRequestPlugin.instance?.token;
    print("configAuth token $token");
    if (token != null) {
      options.headers.addAll({
        "Authorization": "${AnbocasRequestPlugin.instance?.tokenType}$token"
      });
    }
    super.onRequest(options, handler);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInterceptor &&
          runtimeType == other.runtimeType &&
          _tag == other._tag;

  @override
  int get hashCode => _tag.hashCode;
}
