class Currency {
  String? id;
  String? name;
  String? code;
  String? symbol;

  Currency({this.id, this.name, this.code, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["symbol"] is String) {
      symbol = json["symbol"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["code"] = code;
    _data["symbol"] = symbol;
    return _data;
  }
}
