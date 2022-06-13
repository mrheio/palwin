abstract class CustomException implements Exception {
  final String name;
  final String message;
  final int statusCode;

  const CustomException({
    required this.name,
    required this.message,
    required this.statusCode,
  });
}
