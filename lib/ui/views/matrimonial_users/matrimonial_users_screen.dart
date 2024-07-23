import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/models/matrimonial_user/matrimonial_user.dart';
import '../../shared/person_image_view.dart';
import '../../widgets/refresher_listview.dart';
import '../../widgets/text_view.dart';
import 'matrimonial_users_view_model.dart';
// Replace with actual import path

@RoutePage() // Ensure this annotation is correct for navigation
class MatrimonialListScreen extends StatelessWidget {
  const MatrimonialListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MatrimonialListViewModel>.reactive(
      viewModelBuilder: () => MatrimonialListViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              // title: Text('${LocaleKeys.matrimonial.tr()} ${LocaleKeys.users.tr()}'),
              ),
          body: AppRefreshListView(
            refreshController: model.refreshController,
            itemCount: model.matrimonialUsers.length,
            padding: const EdgeInsets.all(15),
            separatorBuilder: (p0, p1) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final user = model.matrimonialUsers[index];
              return MatrimonialUserItemView(user: user);
            },
            onRefresh: model.onRefresh,
            onLoading: model.hasNext ? model.onLoad : null,
          ),
        );
      },
    );
  }
}

class MatrimonialUserItemView extends StatelessWidget {
  final MatrimonialUser user;
  const MatrimonialUserItemView({super.key, required this.user});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonImageView(
                profileUrl: user.profileUrl,
                height: 100,
                width: 80,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    user.fullName,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  TextView(
                    "${user.occupation} (${user.education})",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  if (user.address != null) ...[
                    const SizedBox(height: 10),
                    TextView(
                      user.address!.fullAdress,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
