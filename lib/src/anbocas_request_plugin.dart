import 'package:anbocas_tickets_api/src/api/company_api.dart';
import 'package:anbocas_tickets_api/src/api/event_api.dart';
import 'package:anbocas_tickets_api/src/api/tickets_api.dart';
import 'package:anbocas_tickets_api/src/enums.dart';
import 'package:anbocas_tickets_api/src/request_client.dart';

class AnbocasTicketsApi {
  static AnbocasTicketsApi? _instance;

  static AnbocasTicketsApi? get instance {
    _instance ??= AnbocasTicketsApi();
    return _instance;
  }

  static EventApi get event {
    return EventApi(client: RequestClient.instance!);
  }

  static CompanyApi get company {
    return CompanyApi(client: RequestClient.instance!);
  }

  static TicketsApi get ticket {
    return TicketsApi(client: RequestClient.instance!);
  }

  /// base url
  late String baseUrl;

  /// access token
  String? token;

  /// for Bearer token type.
  static String bearer = 'Bearer ';

  /// set tokenType for types
  String? tokenType = '';

  // set default query parameters to url
  late Map<String, dynamic> defaultQueryParameters = {};

  // set default header
  late Map<String, dynamic> defaultHeaders = {};

  /// to disable log set it to false
  bool enableLog = true;

  ///  when time out.
  Duration? connectTimeout = const Duration(seconds: 30);

  /// mode = sandbox, production
  late ApiMode mode;

  void config({
    String? token,
    String? tokenType,
    Map<String, dynamic>? defaultQueryParameters,
    Map<String, dynamic>? defaultHeaders,
    bool? enableLog,
    ApiMode mode = ApiMode.sandbox,
  }) async {
    if (mode == ApiMode.production) {
      baseUrl = "https://api.anbocas.com";
    } else {
      baseUrl = "https://sandbox.anbocas.com";
    }
    this.token = token ?? this.token;
    this.tokenType = tokenType ?? bearer;
    if (this.defaultQueryParameters.isNotEmpty) {
      this.defaultQueryParameters.addAll(defaultQueryParameters ?? {});
    } else {
      this.defaultQueryParameters =
          defaultQueryParameters ?? this.defaultQueryParameters;
    }
    if (this.defaultHeaders.isNotEmpty) {
      this.defaultHeaders.addAll(defaultHeaders ?? {});
    } else {
      this.defaultHeaders = defaultHeaders ?? this.defaultHeaders;
    }
    this.enableLog = enableLog ?? this.enableLog;
    this.mode = mode ?? this.mode;
  }
}
