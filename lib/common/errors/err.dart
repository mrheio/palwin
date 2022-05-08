abstract class Err implements Exception {
  final String name;
  final String message;
  final int statusCode;

  const Err(
      {required this.name, required this.message, required this.statusCode});
}
