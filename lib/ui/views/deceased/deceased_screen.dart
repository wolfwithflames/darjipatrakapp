import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../list_items/deceased_item_view.dart';
import '../../widgets/refresher_gridview.dart';
import 'deceased_view_model.dart';

@RoutePage()
class DeceasedScreen extends StatelessWidget {
  const DeceasedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeceasedViewModel>.reactive(
      viewModelBuilder: () => DeceasedViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: SafeArea(
            child: AppRefreshGridView(
              refreshController: model.refreshController,
              itemCount: model.deceased.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final deceased = model.deceased[index];
                return DeceasedItemView(deceased: deceased);
              },
              onRefresh: model.onRefresh,
              onLoading: model.hasNext ? model.onLoad : null,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
          ),
        );
      },
    );
  }
}
