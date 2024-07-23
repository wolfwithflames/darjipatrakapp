import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/models/graduated_student_model/graduated_student_model.dart';
import '../shared/person_image_view.dart';
import '../widgets/text_view.dart';

class GraduatedStudentItemView extends StatelessWidget {
  final GraduatedStudentModel graduatedStudent;
  const GraduatedStudentItemView({super.key, required this.graduatedStudent});

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
          PersonImageView(
            profileUrl: graduatedStudent.profileUrl,
          ),
          const SizedBox(height: 10),
          TextView(
            graduatedStudent.fullName,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          TextView(
            graduatedStudent.degree?.shortName,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          TextView(
            graduatedStudent.city,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
