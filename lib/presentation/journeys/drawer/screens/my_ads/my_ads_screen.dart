import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_new_ad_args.dart';
import 'package:yamaiter/presentation/logic/cubit/create_ad/create_ad_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_ads/get_my_ads_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/app_error_type.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/title_with_add_new_item.dart';
import 'my_ads_item.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  late final GetMyAdsCubit _getMyAdsCubit;
  late final CreateAdCubit _createAdCubit;

  @override
  void initState() {
    super.initState();
    _getMyAdsCubit = getItInstance<GetMyAdsCubit>();
    _createAdCubit = getItInstance<CreateAdCubit>();
    _fetchMyAds();
  }

  @override
  void dispose() {
    _getMyAdsCubit.close();
    _createAdCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getMyAdsCubit),
        BlocProvider(create: (context) => _createAdCubit),
      ],
      child: BlocListener<CreateAdCubit, CreateAdState>(
        listener: (context, state) {
          if (state is AdCreatedSuccessfully) {
            _fetchMyAds();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("إعلاناتى"),
          ),
          body: Column(
            children: [
              /// Ads ListView
              const AdsWidget(),

              /// title with add new
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dimen_16.h,
                    bottom: AppUtils.mainPagesVerticalPadding.h,
                    right: AppUtils.mainPagesHorizontalPadding.w,
                    left: AppUtils.mainPagesHorizontalPadding.w,
                  ),
                  child: Column(
                    children: [
                      /// title with add new sos
                      TitleWithAddNewItem(
                        title: "إعلاناتى",
                        addText: "طلب إعلان جديد",
                        onAddPressed: () => _navigateToAddNewAd(context),
                      ),

                      /// list of my sos
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                            child: BlocBuilder<GetMyAdsCubit, GetMyAdsState>(
                              builder: (context, state) {
                                /// loading
                                if (state is LoadingGetMyAdsList) {
                                  return const Center(
                                    child: LoadingWidget(),
                                  );
                                }

                                /// unAuthorized
                                if (state is UnAuthorizedGetMyAdsList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError:
                                          AppErrorType.unauthorizedUser,
                                      buttonText: "تسجيل الدخول",
                                      onPressedRetry: () => _navigateToLogin(),
                                    ),
                                  );
                                }

                                /// notActivatedUser
                                if (state is NotActivatedUserToGetMyAdsList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError:
                                          AppErrorType.notActivatedUser,
                                      buttonText: "تواصل معنا",
                                      onPressedRetry: () =>
                                          _navigateToContactUs(),
                                    ),
                                  );
                                }

                                /// notActivatedUser
                                if (state is ErrorWhileGettingMyAdsList) {
                                  return Center(
                                    child: AppErrorWidget(
                                      appTypeError: state.appError.appErrorType,
                                      onPressedRetry: () => _fetchMyAds(),
                                    ),
                                  );
                                }

                                /// empty
                                if (state is EmptyMyAdsList) {
                                  return Center(
                                    child: Text(
                                      "ليس لديك اعلانات",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColor.primaryDarkColor,
                                          ),
                                    ),
                                  );
                                }

                                /// fetched
                                if (state is MyAdsListFetchedSuccessfully) {
                                  final fetchedList = state.adsList;
                                  return ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: fetchedList.length,
                                    //==> separator
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: Sizes.dimen_2.h,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MyAdItem(
                                        adEntity: fetchedList[index],
                                      );
                                    },
                                  );
                                }

                                /// other
                                /// other
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchMyAds() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyAdsCubit.fetchMyAdsList(userToken: userToken);
  }

  /// to navigate to add new ad
  void _navigateToAddNewAd(BuildContext context) =>
      RouteHelper().addNewAdScreen(
        context,
        addNewAdArguments: AddNewAdArguments(
          createAdCubit: _createAdCubit,
        ),
      );

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
