import 'constants/app_constants.dart';

extension StringExtension on String {
  bool isMaxLength() => length > AppConstants.textMaxLength;
}