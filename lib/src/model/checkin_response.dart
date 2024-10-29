class CheckInResponse {
  String? message;
  late int statusCode;
  String? name;

  CheckInResponse({this.statusCode = 200});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }
}
