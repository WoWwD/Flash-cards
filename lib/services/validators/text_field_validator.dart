import 'package:flash_cards/services/extensions/string_extension.dart';
import '../errors.dart';

class TextFieldValidator {
  static String? get(String value) {
    if (value.toString().isEmpty) {
      return Errors.empty;
    }
    if (value.toString().isMaxLength()) {
      return Errors.maxLength;
    }
    return null;
  }
}