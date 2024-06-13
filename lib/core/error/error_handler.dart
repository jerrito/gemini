
class ErroHandler implements Exception {
  final String error, message;
  final String errorCode;

  ErroHandler({
    required this.error,
    required this.message,
    required this.errorCode,
  });
}

class CustomException extends ErroHandler{
  CustomException({required super.error, required super.message, required super.errorCode});

}
