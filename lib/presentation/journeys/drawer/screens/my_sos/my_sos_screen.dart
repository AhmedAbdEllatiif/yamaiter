import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/enum/app_error_type.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_sos/get_my_sos_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/sos_item/sos_item.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../domain/entities/data/ad_entity.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../widgets/ads_list/ads_list_view.dart';
import '../../../../widgets/title_with_add_new_item.dart';

class MySosScreen extends StatefulWidget {
  const MySosScreen({Key? key}) : super(key: key);

  @override
  State<MySosScreen> createState() => _MySosScreenState();
}

class _MySosScreenState extends State<MySosScreen> {
  late final GetMySosCubit _getMySosCubit;

  @override
  void initState() {
    super.initState();
    _getMySosCubit = getItInstance<GetMySosCubit>();
    _fetchMySosList();
  }

  @override
  void dispose() {
    _getMySosCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getMySosCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("نداءات الاستغاثة"),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
              vertical: AppUtils.mainPagesVerticalPadding.h),
          child: Column(
            children: [
              /// Ads ListView
              const AdsListViewWidget(
                adsList: [
                  AdEntity(id: 0, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                  AdEntity(id: 1, url: AssetsImages.adSample),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: Sizes.dimen_16.h),
                  child: Column(
                    children: [

                      /// title with add new sos
                      TitleWithAddNewItem(
                        title: "نداءات الاستغاثة",
                        addText: "اضف نداء استغاثة",
                        onAddPressed: ()=>_navigateAddSos(),
                      ),

                      /// list of my sos
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding:  EdgeInsets.only(top: Sizes.dimen_10.h),
                            child: BlocBuilder<GetMySosCubit, GetMySosState>(
                                builder: (_, state) {
                              //==> loading
                              if (state is LoadingGetMySosList) {
                                return const Center(
                                  child: LoadingWidget(),
                                );
                              }

                              //==> unAuthorized
                              if (state is UnAuthorizedGetMySosList) {
                                return Center(
                                  child: AppErrorWidget(
                                    appTypeError: AppErrorType.unauthorizedUser,
                                    buttonText: "تسجيل الدخول",
                                    onPressedRetry: () => _navigateToLogin(),
                                  ),
                                );
                              }

                              //==> notActivatedUser
                              if (state is NotActivatedUserToGetMySosList) {
                                return Center(
                                  child: AppErrorWidget(
                                    appTypeError: AppErrorType.notActivatedUser,
                                    buttonText: "تواصل معنا",
                                    onPressedRetry: () => _navigateToContactUs(),
                                  ),
                                );
                              }

                              //==> notActivatedUser
                              if (state is ErrorWhileGettingMySosList) {
                                return Center(
                                  child: AppErrorWidget(
                                    appTypeError: state.appError.appErrorType,
                                    onPressedRetry: () => _fetchMySosList(),
                                  ),
                                );
                              }

                              //==> empty
                              if(state is EmptyMySosList){
                                return Center(
                                  child: Text(
                                    "ليس لديك استغاثات",
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: AppColor.primaryDarkColor,
                                    ),
                                  ),
                                );
                              }

                              //==> fetched
                              if (state is MySosListFetchedSuccessfully) {
                                final fetchedList = state.sosEntityList;
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fetchedList.length,
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: Sizes.dimen_2.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    return SosItem(sosEntity: fetchedList[index],withCallLawyer: false,);
                                  },
                                );
                              }

                              /* return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: Sizes.dimen_2.h,
                                ),
                                itemBuilder: (context, index) {
                                  return const SosItem(sosEntity: SosEntity(
                                    id: 0,
                                    title: "This is title",
                                    description: "This is Description",
                                    creatorName: "Ahmed Mohammed",
                                    creatorPhoneNum: "01124466700",
                                    creatorRating: 4,
                                    governorate: "Cairo",
                                    createdAt: "29-08-2022"
                                  ));
                                },
                              );*/
                              //==> other
                              return const SizedBox.shrink();
                            }),
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

  void _fetchMySosList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMySosCubit.fetchMySosList(userToken: userToken);
  }

  void _navigateAddSos() =>
      RouteHelper().addSos(context);

  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
