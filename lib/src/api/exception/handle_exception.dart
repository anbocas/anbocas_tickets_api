
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:dio/dio.dart';

void handleError(dynamic e) {
  if (e is DioException) {
    if (e.response?.statusCode == 401) {
      throw AnbocasAPIException("Unauthenticated.");
    } else {
      throw AnbocasAPIException("The API threw an exception: ${e.message}");
    }
  } else {
    throw AnbocasAPIException(e.toString());
  }
}
