class AppException with Exception {
  final String _message;
  final bool _error;

  AppException(this._message, this._error);

  @override
  String toString() {
    return "Error code: $_error\nMessage: $_message";
  }
}
