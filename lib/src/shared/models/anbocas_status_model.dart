import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/src/shared/utils/data_serializer.dart';

class AnbocasStatusModel extends Equatable {
  final int all;
  final int published;
  final int draft;
  final int cancelled;
  final int deleted;
  final int checkedIn;
  final int notCheckedIn;
  final int active;
  final int inactive;
  final int completed;
  final int pending;
  final int failed;
  final int available;
  final int soldOut;
  final int outOfStock;

  const AnbocasStatusModel({
    this.all = 0,
    this.published = 0,
    this.draft = 0,
    this.cancelled = 0,
    this.deleted = 0,
    this.checkedIn = 0,
    this.notCheckedIn = 0,
    this.active = 0,
    this.inactive = 0,
    this.completed = 0,
    this.pending = 0,
    this.failed = 0,
    this.available = 0,
    this.soldOut = 0,
    this.outOfStock = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ALL': all,
      'PUBLISHED': published,
      'DRAFT': draft,
      'CANCELLED': cancelled,
      'DELETED': deleted,
      "CHECKED_IN": checkedIn,
      "NOT_CHECKED_IN": notCheckedIn,
      "ACTIVE": active,
      "INACTIVE": inactive,
      "COMPLETED": completed,
      "PENDING": pending,
      "FAILED": failed,
      "AVAILABLE": available,
      "SOLD_OUT": soldOut,
      "OUT_OF_STOCK": outOfStock,
    };
  }

  factory AnbocasStatusModel.fromMap(Map<String, dynamic> map) {
    return AnbocasStatusModel(
      all: DataSerializer.toInt(map['ALL']) ?? 0,
      published: DataSerializer.toInt(map['PUBLISHED']) ?? 0,
      draft: DataSerializer.toInt(map['DRAFT']) ?? 0,
      cancelled: DataSerializer.toInt(map['CANCELLED']) ?? 0,
      deleted: DataSerializer.toInt(map['DELETED']) ?? 0,
      checkedIn: DataSerializer.toInt(map['CHECKED_IN']) ?? 0,
      notCheckedIn: DataSerializer.toInt(map['NOT_CHECKED_IN']) ?? 0,
      active: DataSerializer.toInt(map['ACTIVE']) ?? 0,
      inactive: DataSerializer.toInt(map['INACTIVE']) ?? 0,
      failed: DataSerializer.toInt(map["FAILED"]) ?? 0,
      pending: DataSerializer.toInt(map["PENDING"]) ?? 0,
      completed: DataSerializer.toInt(map["COMPLETED"]) ?? 0,
      available: DataSerializer.toInt(map["AVAILABLE"]) ?? 0,
      soldOut: DataSerializer.toInt(map["SOLD_OUT"]) ?? 0,
      outOfStock: DataSerializer.toInt(map["OUT_OF_STOCK"]) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnbocasStatusModel.fromJson(String source) =>
      AnbocasStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      all,
      published,
      draft,
      cancelled,
      deleted,
      checkedIn,
      notCheckedIn,
      active,
      inactive,
      failed,
      pending,
      completed,
      available,
      soldOut,
      outOfStock,
    ];
  }
}
