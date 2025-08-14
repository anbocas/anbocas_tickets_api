import 'package:equatable/equatable.dart';

class AnbocasOrderLogModel extends Equatable {
  final String? id;
  final String? orderId;
  final String? text;
  final String? createdAt;

  const AnbocasOrderLogModel({
    this.id,
    this.orderId,
    this.text,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        text,
        createdAt,
      ];

  factory AnbocasOrderLogModel.fromJson(Map<String, dynamic> json) {
    return AnbocasOrderLogModel(
      id: json["id"],
      orderId: json["order_id"],
      text: json["text"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "text": text,
      "created_at": createdAt,
    };
  }

  AnbocasOrderLogModel copyWith({
    String? id,
    String? orderId,
    String? text,
    String? createdAt,
  }) {
    return AnbocasOrderLogModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
