import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/extenstions/date_extenstions.dart';
import '../../core/generated/locale_keys.g.dart';
import '../../core/models/deceased/deceased.dart';
import '../widgets/image_view.dart';
import '../widgets/text_view.dart';

class DeceasedItemView extends StatelessWidget {
  final Deceased deceased;
  const DeceasedItemView({super.key, required this.deceased});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextView(
            deceased.fullName,
            fontSize: 18,
            fontFamily: Constants.notoSansGujarati,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Constants.defaultBorderRadius,
              ),
              border: Border.all(
                width: 2,
                color: AppColors.secondaryColor,
              ),
            ),
            height: 150,
            width: 130,
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Constants.defaultBorderRadius - 2,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ImageView(
                deceased.photoUrl,
                ImageType.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          DateViewWithTitle(
            title: "${LocaleKeys.birth.tr()}: ",
            value: deceased.dateOfBirth.birthDate ?? "",
          ),
          const SizedBox(height: 5),
          DateViewWithTitle(
            title: "${LocaleKeys.deceased.tr()}: ",
            value: deceased.dateOfDeath.birthDate ?? "",
          ),
          const SizedBox(height: 10),
          TextView(
            deceased.placeOfBirth,
            fontFamily: Constants.notoSansGujarati,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          )
        ],
      ),
    );
  }
}

class DateViewWithTitle extends StatelessWidget {
  final String title;
  final String value;
  const DateViewWithTitle({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontFamily: Constants.notoSansGujarati,
          fontWeight: FontWeight.w400,
          color: AppColors.unselectedColor,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontFamily: Constants.notoSansGujarati,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
