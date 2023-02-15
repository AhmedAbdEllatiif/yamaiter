import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/consultation_details_args.dart';
import 'package:yamaiter/presentation/logic/client_cubit/get_consultation_details/get_consultation_details_cubit.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/ads_pages.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/text_with_icon.dart';

class ConsultationDetailScreen extends StatefulWidget {
  final ConsultationDetailsArguments arguments;

  const ConsultationDetailScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ConsultationDetailScreen> createState() =>
      _ConsultationDetailScreenState();
}

class _ConsultationDetailScreenState extends State<ConsultationDetailScreen> {
  late final GetConsultationDetailsCubit _detailsCubit;
  late final ConsultationEntity _consultationEntity;

  @override
  void initState() {
    super.initState();
    _detailsCubit = getItInstance<GetConsultationDetailsCubit>();
    _consultationEntity = widget.arguments.consultationEntity;
  }

  @override
  void dispose() {
    _detailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailsCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("تفاصيل الاستشارة"),
        ),

        body: Column(
          children: [
            /// ads
            const AdsWidget(
                adsPage: AdsPage.innerPage
            ),

            /// ScrollableAppCard
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppUtils.mainPagesHorizontalPadding.w,
              ),
              child: ScrollableAppCard(
                ///==> title of ScrollableAppCard
                title: Column(
                  children: [
                    //==> consultation title
                    AppContentTitleWidget(
                      title: _consultationEntity.type,
                      textSpace: 1.3,
                    ),

                    // space
                    SizedBox(height: Sizes.dimen_5.h),

                    //==> date
                    TextWithIconWidget(
                      iconData: Icons.date_range_outlined,
                      text: _consultationEntity.createdAt,
                    ),
                  ],
                ),

                ///==> child of ScrollableAppCard
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //==> consultation description
                    Text(
                      _consultationEntity.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, height: 1.4),
                    ),

                    // space
                    SizedBox(height: Sizes.dimen_20.h),

                    //==> feedback title
                    Text(
                      "الرد على الاستشارة",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                    ),

                    // space
                    SizedBox(height: Sizes.dimen_8.h),

                    //==> feedback
                    _consultationEntity.feedBack == AppUtils.undefined
                        ? Center(
                            child: Text(
                              "مازالت الاسشارة قيد المراجعة",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.black,
                                    height: 1.4,
                                  ),
                            ),
                          )
                        : Text(
                            _consultationEntity.feedBack,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      height: 1.4,
                                    ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
