import 'package:anbocas_tickets_api/src/shared/models/anbocas_status_model.dart';
import 'package:equatable/equatable.dart';

class AnbocasPaginatedResponse<T> extends Equatable {
  final T data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final AnbocasStatusModel status;

  const AnbocasPaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.status,
  });

  @override
  List<Object?> get props => [
        data,
        currentPage,
        lastPage,
        perPage,
        status,
      ];

  AnbocasPaginatedResponse<T> copyWith({
    T? data,
    int? currentPage,
    int? lastPage,
    int? perPage,
    AnbocasStatusModel? status,
  }) {
    return AnbocasPaginatedResponse<T>(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      status: status ?? this.status,
    );
  }
}
