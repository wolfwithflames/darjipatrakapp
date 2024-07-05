import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stacked/stacked.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/extenstions/date_extenstions.dart';
import '../../../core/generated/locale_keys.g.dart';
import '../../shared/date_view_with_title.dart';
import '../../shared/person_image_view.dart';
import '../../widgets/image_view.dart';
import '../../widgets/refresher_listview.dart';
import '../../widgets/text_view.dart';
import 'deceased_details_view_model.dart';

@RoutePage()
class DeceasedDetailsScreen extends StatelessWidget {
  final String id;
  const DeceasedDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeceasedDetailsViewModel>.reactive(
      viewModelBuilder: () => DeceasedDetailsViewModel(deceasedId: id)..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: SafeArea(
            child: AppRefreshListView(
              refreshController: model.refreshController,
              itemCount: 1,
              snapshotStatus: model.apiResponseStatus,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _diya,
                        PersonImageView(
                          profileUrl: model.deceased?.photoUrl,
                          height: 250,
                          width: 200,
                        ),
                        _diya,
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextView(
                      model.deceased?.fullName,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DateViewWithTitle(
                              title: "${LocaleKeys.birth.tr()}: ",
                              value:
                                  model.deceased!.dateOfBirth!.birthDate ?? "",
                              fontSize: 18,
                            ),
                            _placeText("(${model.deceased?.placeOfBirth})"),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DateViewWithTitle(
                              title: "${LocaleKeys.deceased.tr()}: ",
                              value:
                                  model.deceased!.dateOfDeath!.birthDate ?? "",
                              fontSize: 18,
                            ),
                            _placeText("(${model.deceased?.placeOfDeath})"),
                          ],
                        ),
                      ],
                    ),
                    if (model.deceased!.tagline != null ||
                        model.deceased!.tagline!.isNotEmpty) ...[
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextView(
                          model.deceased!.tagline! * 5,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: _placeText(LocaleKeys.yourIndebtedness.tr()),
                    ),
                    const SizedBox(height: 10),
                    if (model.deceased!.relatives != null &&
                        model.deceased!.relatives!.isNotEmpty) ...[
                      _placeText(
                        model.deceased!.relatives!.first.nameWithRelation,
                      ),
                      const SizedBox(height: 10),
                      MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                        itemBuilder: (context, index) {
                          return Center(
                            child: _placeText(
                              model.deceased!.relatives![index + 1]
                                  .nameWithRelation,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: model.deceased!.relatives!.length - 1,
                      )
                    ]
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget get _diya => ImageView(
        AppAssets.diya,
        ImageType.svg,
        height: 60,
        width: 60,
      );

  TextView _placeText(String text) {
    return TextView(
      text,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
  }
}
