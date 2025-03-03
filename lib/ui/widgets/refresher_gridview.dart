import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/data/enums.dart';
import 'edit_text.dart';
import 'loader_view.dart';
import 'no_data_view.dart';

class AppRefreshGridView extends StatelessWidget {
  final void Function()? onRefresh;
  final void Function()? onSearch;
  final Function()? onLoading;
  final RefreshController refreshController;
  final TextEditingController? searchController;

  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? searchPrefix;
  final int itemCount;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final String noDataText;
  final bool? showClearSearch;
  final ApiResponseStatus snapshotStatus;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const AppRefreshGridView({
    super.key,
    this.onRefresh,
    this.onSearch,
    required this.refreshController,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollController,
    this.shrinkWrap = false,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.onLoading,
    this.searchPrefix,
    this.noDataText = "No data available",
    this.searchController,
    this.showClearSearch = false,
    this.snapshotStatus = ApiResponseStatus.success,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: onSearch != null,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: EditText(
                    hint: "Search",
                    enable: true,
                    prefixIcon: searchPrefix,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Number";
                      }
                      if (val.length != 10) {
                        return "Enter 10 Digit Number";
                      }
                      return null;
                    },
                    contentPadding: const EdgeInsets.only(left: 20, top: 15),
                    controller: searchController,
                    fontWeight: FontWeight.w500,
                    onChanged: (p0) {
                      if (onSearch != null) {
                        onSearch!();
                      }
                    },
                    suffixIcon: Visibility(
                      visible: showClearSearch ?? false,
                      child: IconButton(
                        onPressed: () {
                          searchController?.clear();
                          if (onSearch != null) {
                            onSearch!();
                          }
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    textAlign: TextAlign.justify,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.forward) {
                FocusScope.of(context).unfocus();
              }
              return false;
            },
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: onRefresh,
              onLoading: onLoading,
              enablePullDown: onRefresh != null,
              enablePullUp: onLoading != null,
              physics: const ClampingScrollPhysics(),
              child: _builder(context),
            ),
          ),
        )
      ],
    );
  }

  Widget _builder(BuildContext context) {
    switch (snapshotStatus) {
      case ApiResponseStatus.loading:
        return const LoaderView();
      case ApiResponseStatus.success:
        return _listBuilder(context);
      case ApiResponseStatus.error:
        return NoDataView(
          noDataText: "Something went wrong",
        );
    }
  }

  Widget _listBuilder(BuildContext context) {
    return itemCount != 0
        ? MasonryGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            itemBuilder: itemBuilder,
            padding: padding,
            shrinkWrap: shrinkWrap,
            physics: const ClampingScrollPhysics(),
            scrollDirection: scrollDirection,
            itemCount: itemCount,
            controller: scrollController,
          )
        : NoDataView(
            noDataText: noDataText,
          );
  }
}
