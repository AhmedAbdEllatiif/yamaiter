import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/logic/cubit/top_rated_lawyers/top_rated_lawyers_cubit.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/presentation/widgets/rounded_text.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/screen_arguments/invite_lawyer_args.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../app_button.dart';
import '../app_error_widget.dart';
import '../loading_widget.dart';

class TopRatedLawyersWidget extends StatefulWidget {
  const TopRatedLawyersWidget({Key? key}) : super(key: key);

  @override
  State<TopRatedLawyersWidget> createState() => _TopRatedLawyersWidgetState();
}

class _TopRatedLawyersWidgetState extends State<TopRatedLawyersWidget> {
  late final TopRatedLawyersCubit _topRatedLawyersCubit;

  @override
  void initState() {
    super.initState();
    _topRatedLawyersCubit = getItInstance<TopRatedLawyersCubit>();
    _fetchTopRatedLawyers();
  }

  @override
  void dispose() {
    _topRatedLawyersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _topRatedLawyersCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<TopRatedLawyersCubit, TopRatedLawyersState>(
          builder: (context, state) {
            //==> loading
            if (state is LoadingTopRatedLawyers) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            //==> unAuthorized
            if (state is UnAuthorizedTopRatedLawyers) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is ErrorWhileLoadingTopRatedLawyers) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchTopRatedLawyers(),
                ),
              );
            }

            //==> empty
            if (state is EmptyTopRatedLawyers) {
              return Center(
                child: Text(
                  "لايوجد محامين",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            //==> fetched
            if (state is TopRatedLawyersFetched) {

              return CarouselSlider(
                options: CarouselOptions(
                  height: ScreenUtil.screenHeight * 0.18,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
                items: state.lawyerList.map((lawyer) {
                 // final lawyer = state.lawyerList[index];
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// image
                              ImageNameRatingWidget(
                                imgUrl: lawyer.profileImage,
                                name: lawyer.name,
                                rating: lawyer.rating.toDouble(),
                                withRow: false,
                                nameColor: AppColor.primaryDarkColor,
                                ratedColor: AppColor.accentColor,
                                unRatedColor: AppColor.primaryColor,
                                iconRateSize: Sizes.dimen_12.w,
                                minImageSize: Sizes.dimen_40,
                                maxImageSize: Sizes.dimen_40,
                              ),

                              /// description
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                          lawyer.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(height: 1.3),
                                        )),

                                    /// tasksCount , button
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${lawyer.tasksCount} مهمة",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(height: .5),
                                        ),
                                        RoundedText(
                                            text: "دعوة لمهمة",
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                              color: AppColor.accentColor,
                                            ),
                                            // color: AppColor.primaryDarkColor,
                                            onPressed: () {
                                              _navigateToInviteLawyerScreen(
                                                lawyerId: lawyer.id,
                                              );
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
           /*   return Flexible(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  // count
                  itemCount: state.lawyerList.length,

                  // separated
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),

                  // item
                  itemBuilder: (context, index) {
                    final lawyer = state.lawyerList[index];
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: ScreenUtil.screenWidth - 100,
                        maxWidth: ScreenUtil.screenWidth - 30,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// image
                              ImageNameRatingWidget(
                                imgUrl: lawyer.profileImage,
                                name: lawyer.name,
                                rating: lawyer.rating.toDouble(),
                                withRow: false,
                                nameColor: AppColor.primaryDarkColor,
                                ratedColor: AppColor.accentColor,
                                unRatedColor: AppColor.primaryColor,
                                iconRateSize: Sizes.dimen_12.w,
                                minImageSize: Sizes.dimen_40,
                                maxImageSize: Sizes.dimen_40,
                              ),

                              /// description
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      lawyer.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(height: 1.3),
                                    )),

                                    /// tasksCount , button
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${lawyer.tasksCount} مهمة",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(height: .5),
                                        ),
                                        RoundedText(
                                            text: "دعوة لمهمة",
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: AppColor.accentColor,
                                                ),
                                            // color: AppColor.primaryDarkColor,
                                            onPressed: () {
                                              _navigateToInviteLawyerScreen(
                                                lawyerId: lawyer.id,
                                              );
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );*/
            }

            //==> else
            return const SizedBox.shrink();
          },
        );
      }),
    );
  }

  /// to fetch top rated lawyers
  void _fetchTopRatedLawyers() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _topRatedLawyersCubit.fetchToRatedLawyers(
      userToken: userToken,
    );
  }

  void _navigateToInviteLawyerScreen({required int lawyerId}) {
    RouteHelper().inviteLawyer(context,
        inviteLawyerArguments: InviteLawyerArguments(
          lawyerId: lawyerId,
        ));
  }

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contact us
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
