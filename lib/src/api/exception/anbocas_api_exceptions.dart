part of anbocas_tickets_api;

/// Custom Exception for the plugin,
/// Thrown whenever the API responds with an error and body could not be parsed.
class AnbocasAPIException implements Exception {
  String _cause;

  AnbocasAPIException(this._cause);

  @override
  String toString() => '$runtimeType - $_cause';
}

class AnbocasFieldException implements Exception {
  String _error;

  AnbocasFieldException(this._error);

  @override
  String toString() => '$runtimeType - $_error';
}
