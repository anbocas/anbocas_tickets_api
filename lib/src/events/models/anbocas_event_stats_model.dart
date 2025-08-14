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

  factory AnbocasEventStatsModel.fromJson(Map<String, dynamic> json) {
    return AnbocasEventStatsModel(
      title: json["title"],
      value: json["value"],
      isAmount: json["is_amount"],
    );
  }

  Map<String, dynamic> toJson() {
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
