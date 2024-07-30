import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../list_items/deceased_item_view.dart';
import '../../list_items/graduated_student_item_view.dart';
import '../../widgets/refresher_listview.dart';
import '../../widgets/text_view.dart';
import '../matrimonial_users/matrimonial_users_screen.dart';
import 'dashboard_view_model.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          body: AppRefreshListView(
            refreshController: model.refreshController,
            itemCount: 1,
            snapshotStatus: model.apiResponseStatus,
            itemBuilder: (context, index) {
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 175,
                    child: DashboardItemsHorizontalListview(
                      itemCount: model.matrimonialUsers.length,
                      itemBuilder: (context, index) => MatrimonialUserItemView(
                        user: model.matrimonialUsers[index],
                      ),
                      onViewMoreTap: model.onMatrimonialViewMoreTap,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    child: DashboardItemsHorizontalListview(
                      itemCount: model.deceasedUsers.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 180,
                        child: DeceasedItemView(
                          deceased: model.deceasedUsers[index],
                        ),
                      ),
                      onViewMoreTap: model.onDeceasedViewMoreTap,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 315,
                    child: DashboardItemsHorizontalListview(
                      itemCount: model.students.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 180,
                        child: GraduatedStudentItemView(
                          graduatedStudent: model.students[index],
                        ),
                      ),
                      onViewMoreTap: model.onStudentsViewMoreTap,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class DashboardItemsHorizontalListview extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onViewMoreTap;
  final Widget? Function(BuildContext, int) itemBuilder;
  const DashboardItemsHorizontalListview({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onViewMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onViewMoreTap != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onViewMoreTap,
              child: const TextView("View More"),
            ),
          ),
        ],
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
