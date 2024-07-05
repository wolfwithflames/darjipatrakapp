import 'package:flutter/widgets.dart';

import '../../core/constants/app_colors.dart';

class DateViewWithTitle extends StatelessWidget {
  final String title;
  final String value;
  final double? fontSize;
  const DateViewWithTitle({
    super.key,
    required this.title,
    required this.value,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.unselectedColor,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
