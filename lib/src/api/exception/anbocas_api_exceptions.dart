part of '../../../anbocas_tickets_api.dart';

/// Custom Exception for the plugin,
/// Thrown whenever the API responds with an error and body could not be parsed.
class AnbocasAPIException implements Exception {
  String cause;

  AnbocasAPIException(this.cause);

  @override
  String toString() => '$runtimeType - $cause';
}

class AnbocasFieldException implements Exception {
  final String _error;

  AnbocasFieldException(this._error);

  @override
  String toString() => '$runtimeType - $_error';
}
