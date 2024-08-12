import 'package:dio/dio.dart';

class ApiLogInterceptor extends Interceptor {
  final String _tag = 'log';

  ApiLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  void Function(Object object) logPrint;

  void Function(Object object) infoPrint = (Object object) {
    print('\u001b[92m$object\u001b[0m');
  };
  void Function(Object object) respPrint = (Object object) {
    print('\u001b[96m$object\u001b[0m');
  };

  void Function(Object object) errorPrint = (Object object) {
    print('\u001b[91m$object\u001b[0m');
  };

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    infoPrint('*** Api Request ***');
    _printKV('uri', options.uri);

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType.toString());
      _printKV('connectTimeout', options.connectTimeout);
    }
    if (requestHeader) {
      infoPrint('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      infoPrint('data:');
      if (options.data is FormData) {
        _printKV(
            'fields: ',
            options.data.fields
                .map((MapEntry entry) => '${entry.key}: ${entry.value}'));
        _printKV('files: ', options.data.files);
      } else {
        _printAll(options.data);
      }
    }
    logPrint('');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    infoPrint('*** Api Response ***');
    _printResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (error) {
      errorPrint('*** ApiRequestError ***:');
      errorPrint('uri: ${err.requestOptions.uri}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      logPrint('');
    }

    handler.next(err);
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }

      infoPrint('headers:');
      response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    }
    if (responseBody) {
      infoPrint('Response Text:');
      _printAll(response.toString());
    }
    logPrint('');
  }

  void _printKV(String key, Object? v) {
    logPrint('\x1B[93m$key\x1B[0m: \x1B[97m$v\x1B[0m');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(respPrint);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiLogInterceptor &&
          runtimeType == other.runtimeType &&
          _tag == other._tag;

  @override
  int get hashCode => _tag.hashCode;
}
