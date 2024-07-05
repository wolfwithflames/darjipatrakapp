import 'package:flutter/widgets.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/constants.dart';
import '../widgets/image_view.dart';

class PersonImageView extends StatelessWidget {
  const PersonImageView({
    super.key,
    required this.profileUrl,
    this.height = 150,
    this.width = 130,
  });

  final String? profileUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Constants.defaultBorderRadius,
        ),
        border: Border.all(
          width: 2,
          color: AppColors.secondaryColor,
        ),
      ),
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Constants.defaultBorderRadius - 2,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: ImageView(
          profileUrl,
          ImageType.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
