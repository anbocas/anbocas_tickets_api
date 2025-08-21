import 'package:anbocas_tickets_api/src/shared/utils/data_serializer.dart';
import 'package:equatable/equatable.dart';

class AnbocasEventStatsModel extends Equatable {
  final String? title;
  final int? value;
  final bool? isAmount;

  const AnbocasEventStatsModel({
    this.title,
    this.value,
    this.isAmount,
  });

  @override
  List<Object?> get props => [
        title,
        value,
        isAmount,
      ];

  factory AnbocasEventStatsModel.fromMap(Map<String, dynamic> map) {
    return AnbocasEventStatsModel(
      title: map["title"],
      value: DataSerializer.toInt(map["value"]),
      isAmount: DataSerializer.toBool(map["is_amount"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "value": value,
      "is_amount": isAmount,
    };
  }

  AnbocasEventStatsModel copyWith({
    String? title,
    int? value,
    bool? isAmount,
  }) {
    return AnbocasEventStatsModel(
      title: title ?? this.title,
      value: value ?? this.value,
      isAmount: isAmount ?? this.isAmount,
    );
  }
}
