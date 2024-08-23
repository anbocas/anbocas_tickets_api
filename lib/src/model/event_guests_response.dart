class EventGuestsResponse {
  List<EventGuests> data = [];
  Status? status;

  EventGuestsResponse({required this.data, this.status});

  EventGuestsResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data =
          (json["data"] as List).map((e) => EventGuests.fromJson(e)).toList();
    }
    if (json["status"] is Map) {
      status = json["status"] == null ? null : Status.fromJson(json["status"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["data"] = data.map((e) => e.toJson()).toList();
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    return _data;
  }
}

class Status {
  int all = 0;
  int checkedIn = 0;
  int notCheckedIn = 0;

  Status(
      {required this.all, required this.checkedIn, required this.notCheckedIn});

  Status.fromJson(Map<String, dynamic> json) {
    if (json["ALL"] is int) {
      all = json["ALL"];
    }
    if (json["CHECKED_IN"] is int) {
      checkedIn = json["CHECKED_IN"];
    }
    if (json["NOT_CHECKED_IN"] is int) {
      notCheckedIn = json["NOT_CHECKED_IN"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ALL"] = all;
    _data["CHECKED_IN"] = checkedIn;
    _data["NOT_CHECKED_IN"] = notCheckedIn;
    return _data;
  }
}

class EventGuests {
  String? name;
  String? email;
  dynamic phone;
  String? code;
  String? checkInTime;
  late String status;

  EventGuests(
      {this.name,
      this.email,
      this.phone,
      this.code,
      this.checkInTime,
     
      this.status = 'NOT_CHECKED_IN'});

  EventGuests.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    phone = json["phone"];
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["check_in_time"] is String) {
      checkInTime = json["check_in_time"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["code"] = code;
    _data["check_in_time"] = checkInTime;
    _data["status"] = status;
    return _data;
  }
}
