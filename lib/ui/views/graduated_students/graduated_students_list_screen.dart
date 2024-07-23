import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/generated/locale_keys.g.dart';
import '../../list_items/graduated_student_item_view.dart';
import '../../widgets/refresher_gridview.dart';
import 'graduated_students_view_model.dart';

@RoutePage()
class GraduatedStudentsListScreen extends StatelessWidget {
  const GraduatedStudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GraduatedStudentsListViewModel>.reactive(
      viewModelBuilder: () => GraduatedStudentsListViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${LocaleKeys.cast.tr()}${LocaleKeys.s.tr()} ${LocaleKeys.pride.tr()}'),
          ),
          body: AppRefreshGridView(
            refreshController: model.refreshController,
            itemCount: model.graduatedStudents.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final graduatedStudent = model.graduatedStudents[index];
              return GraduatedStudentItemView(
                graduatedStudent: graduatedStudent,
              );
            },
            onRefresh: model.onRefresh,
            onLoading: model.hasNext ? model.onLoad : null,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
        );
      },
    );
  }
}
