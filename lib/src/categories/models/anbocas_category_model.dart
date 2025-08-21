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

  factory AnbocasCategoryModel.fromMap(Map<String, dynamic> map) {
    return AnbocasCategoryModel(
      id: map["id"],
      userId: map["user_id"],
      name: map["name"],
      slug: map["slug"],
      parentId: map["parent_id"],
      createdAt: DateTime.tryParse(map["created_at"] ?? ''),
      updatedAt: DateTime.tryParse(map["updated_at"] ?? ''),
      deletedAt: DateTime.tryParse(map["deleted_at"] ?? ''),
      status: map["status"] != null
          ? AnbocasCategoryStatus.fromValue(map["status"])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
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
