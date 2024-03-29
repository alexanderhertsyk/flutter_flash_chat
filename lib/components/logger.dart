mixin Logger {
  void log(Object e, StackTrace st) {
    print('Exception: $e');
    print('StackTrace: $st');
  }
}
