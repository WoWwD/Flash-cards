import 'package:flash_cards/services/extensions/string_extension.dart';
import '../errors/input_errors.dart';

class TextFieldValidator {
  static String? get(String value) {
    if (value.toString().isEmpty) {
      return InputErrors.empty;
    }
    if (value.toString().isMaxLength()) {
      return InputErrors.maxLength;
    }
    return null;
  }
}