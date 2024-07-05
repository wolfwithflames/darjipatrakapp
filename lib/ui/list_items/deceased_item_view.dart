import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/extenstions/date_extenstions.dart';
import '../../core/generated/locale_keys.g.dart';
import '../../core/models/deceased/deceased.dart';
import '../shared/date_view_with_title.dart';
import '../shared/person_image_view.dart';
import '../widgets/text_view.dart';

typedef DeceasedPressed = Function(Deceased);

/// Represents a widget that displays information about a deceased person.
/// This widget includes the deceased's full name, photo, birth and death dates, and place of birth.
/// It also allows for a tap action to be performed when tapped.
class DeceasedItemView extends StatelessWidget {
  final Deceased deceased;
  final DeceasedPressed? onTap;
  const DeceasedItemView({
    super.key,
    required this.deceased,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(deceased) : null,
      child: Container(
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
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            PersonImageView(profileUrl: deceased.photoUrl),
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
              fontWeight: FontWeight.w700,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }
}
