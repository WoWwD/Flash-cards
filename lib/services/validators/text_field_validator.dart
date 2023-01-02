import 'package:flash_cards/services/extensions/string_extension.dart';
import '../strings.dart';

class TextFieldValidator {
  static String? get(String value) {
    if (value.toString().isEmpty) {
      return Strings.empty;
    }
    if (value.toString().isMaxLength()) {
      return Strings.maxLength;
    }
    return null;
  }
}