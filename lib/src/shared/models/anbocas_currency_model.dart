import 'package:equatable/equatable.dart';

class AnbocasCurrencyModel extends Equatable {
  final String? id;
  final String? name;
  final String? code;
  final String? symbol;

  const AnbocasCurrencyModel({
    this.id,
    this.name,
    this.code,
    this.symbol,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        symbol,
      ];

  factory AnbocasCurrencyModel.fromMap(Map<String, dynamic> map) {
    return AnbocasCurrencyModel(
      id: map["id"],
      name: map["name"],
      code: map["code"],
      symbol: map["symbol"],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["code"] = code;
    data["symbol"] = symbol;
    return data;
  }

  AnbocasCurrencyModel copyWith({
    String? id,
    String? name,
    String? code,
    String? symbol,
  }) {
    return AnbocasCurrencyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
    );
  }
}
