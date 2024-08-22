class CheckInResponse {
  String? message;
  late int statusCode;

CheckInResponse({this.statusCode=200});
  

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
  }
}
