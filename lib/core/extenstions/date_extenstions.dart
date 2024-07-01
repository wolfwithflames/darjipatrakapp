import 'package:easy_localization/easy_localization.dart';

extension AppDateExtenstion on DateTime? {
  String? get birthDate {
    if (this == null) {
      return null;
    }
    String formattedDate = DateFormat.yMMMMd('gu_IN').format(this!);
    return convertDigitsToGujarati(formattedDate);
  }
}

String convertDigitsToGujarati(String input) {
  const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const gujaratiDigits = ['૦', '૧', '૨', '૩', '૪', '૫', '૬', '૭', '૮', '૯'];

  for (int i = 0; i < englishDigits.length; i++) {
    input = input.replaceAll(englishDigits[i], gujaratiDigits[i]);
  }
  return input;
}
