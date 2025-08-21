import 'package:equatable/equatable.dart';

class AnbocasOrderLogModel extends Equatable {
  final String? id;
  final String? orderId;
  final String? text;
  final DateTime? createdAt;

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

  factory AnbocasOrderLogModel.fromMap(Map<String, dynamic> map) {
    return AnbocasOrderLogModel(
      id: map["id"],
      orderId: map["order_id"],
      text: map["text"],
      createdAt: DateTime.tryParse(map["created_at"] ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "order_id": orderId,
      "text": text,
      "created_at": createdAt?.toString(),
    };
  }

  AnbocasOrderLogModel copyWith({
    String? id,
    String? orderId,
    String? text,
    DateTime? createdAt,
  }) {
    return AnbocasOrderLogModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
