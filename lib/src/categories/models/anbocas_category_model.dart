import 'package:anbocas_tickets_api/src/categories/constants/anbocas_category_status.dart';
import 'package:equatable/equatable.dart';

class AnbocasCategoryModel extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final AnbocasCategoryStatus? status;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? parentId;

  const AnbocasCategoryModel({
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.parentId,
  });

  @override
  List<Object?> get props => [
        status,
        createdAt,
        updatedAt,
        deletedAt,
        id,
        userId,
        name,
        slug,
        parentId,
      ];

  factory AnbocasCategoryModel.fromJson(Map<String, dynamic> json) {
    return AnbocasCategoryModel(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      slug: json["slug"],
      parentId: json["parent_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ''),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
      deletedAt: DateTime.tryParse(json["deleted_at"] ?? ''),
      status: json["status"] != null
          ? AnbocasCategoryStatus.fromValue(json["status"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "name": name,
      "slug": slug,
      "status": status?.value,
      "created_at": createdAt.toString(),
      "updated_at": updatedAt.toString(),
      "deleted_at": deletedAt.toString(),
      "parent_id": parentId,
    };
  }

  AnbocasCategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? slug,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    AnbocasCategoryStatus? status,
  }) {
    return AnbocasCategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      status: status ?? this.status,
    );
  }
}
