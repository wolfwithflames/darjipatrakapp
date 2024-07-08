import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
            title: const Text(''),
          ),
          body: Container(),
        );
      },
    );
  }
}
