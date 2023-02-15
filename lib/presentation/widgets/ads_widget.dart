import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/common/app_announcements/get_app_announcements_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/assets_constants.dart';
import '../../common/enum/ads_pages.dart';
import '../../common/functions/get_user_token.dart';
import '../../domain/entities/data/ad_entity.dart';
import 'ads_list/ads_list_view.dart';

class AdsWidget extends StatefulWidget {
  final List<AdEntity>? adsList;

  const AdsWidget({Key? key, this.adsList}) : super(key: key);

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  late final GetAppAnnouncementsCubit _announcementsCubit;

  @override
  void initState() {
    super.initState();
    _announcementsCubit = getItInstance<GetAppAnnouncementsCubit>();
    _fetchAppAnnouncements();
  }

  @override
  void dispose() {
    _announcementsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _announcementsCubit,
      child: Padding(
        padding: EdgeInsets.only(
          right: AppUtils.mainPagesHorizontalPadding.w,
          left: AppUtils.mainPagesHorizontalPadding.w,
          top: AppUtils.mainPagesVerticalPadding.h,
        ),
        child: BlocBuilder<GetAppAnnouncementsCubit, GetAppAnnouncementsState>(
          builder: (context, state) {
            /*
            *
            *
            * loading
            *
            *
            * */
            if (state is LoadingGetAppAnnouncements) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            if (state is AppAnnouncementsFetchedSuccessfully) {
              return Column(
                children: [
                  /// ads
                  AdsListViewWidget(adsList: state.adsList),

                  /// space
                  const SizedBox(height: 10),

                  /// news
                  Container(
                    height: ScreenUtil.screenHeight * 0.05,
                    width: double.infinity,
                    color: AppColor.primaryDarkColor,
                    child: Marquee(
                      text: state.newsAsString,
                      blankSpace: 100.0,
                      velocity: 50.0,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AppColor.white),
                      // scrollAxis: Axis.horizontal,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // blankSpace: 20.0,
                      // velocity: 100.0,
                      // pauseAfterRound: Duration(seconds: 1),
                      // startPadding: 10.0,
                      // accelerationDuration: Duration(seconds: 1),
                      // accelerationCurve: Curves.linear,
                      // decelerationDuration: Duration(milliseconds: 500),
                      // decelerationCurve: Curves.easeOut,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// fetch app announcements
  void _fetchAppAnnouncements() {
    final userToken = getUserToken(context);
    final adsPlace = AdsPage.main.toShortString();

    _announcementsCubit.tryToGetAppAnnouncements(
      adsPlace: "",
      userToken: userToken,
    );
  }
}
