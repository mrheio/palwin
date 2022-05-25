class Success {
  final String message;

  const Success({this.message = ''});

  bool get hasMessage => message.isNotEmpty;
}
