import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/generated/locale_keys.g.dart';
import '../../list_items/deceased_item_view.dart';
import '../../widgets/refresher_gridview.dart';
import 'deceased_list_view_model.dart';

/// Widget for displaying a list of deceased items using a ViewModelBuilder to manage the state.
/// It includes a Scaffold with an AppBar and a SafeArea containing an AppRefreshGridView.
/// The AppRefreshGridView is used to display the list of deceased items with a grid layout.
/// It handles refreshing, loading more items, and tapping on individual deceased items.
@RoutePage()
class DeceasedListScreen extends StatelessWidget {
  const DeceasedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeceasedListViewModel>.reactive(
      viewModelBuilder: () => DeceasedListViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${LocaleKeys.deceased.tr()} ${LocaleKeys.done.tr()}'),
          ),
          body: AppRefreshGridView(
            refreshController: model.refreshController,
            itemCount: model.deceased.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final deceased = model.deceased[index];
              return DeceasedItemView(
                deceased: deceased,
                onTap: model.onDeceasedPressed,
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
