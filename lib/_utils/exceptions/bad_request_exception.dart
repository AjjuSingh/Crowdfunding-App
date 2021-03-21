import 'package:crowdfund_app/_utils/exceptions/app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException(String message, bool error) : super(message, error);
}
