class Success {
  final String message;

  const Success(this.message);

  bool get hasMessage => message.isNotEmpty;
  bool get isEmpty => this == empty;

  static const empty = Success('');
}
