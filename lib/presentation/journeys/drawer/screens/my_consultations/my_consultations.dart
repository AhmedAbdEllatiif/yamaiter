import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../../../../common/constants/app_utils.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/app_error_type.dart';
import '../../../../../../di/git_it_instance.dart';
import '../../../../../../domain/entities/data/client/consultation_entity.dart';
import '../../../../../../router/route_helper.dart';
import '../../../../logic/client_cubit/get_my_consultations/get_my_consultations_cubit.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/title_with_add_new_item.dart';
import 'loading_more_my_consultations.dart';
import 'my_consultation_item.dart';

class MyConsultationScreen extends StatefulWidget {
  const MyConsultationScreen({Key? key}) : super(key: key);

  @override
  State<MyConsultationScreen> createState() => _MyConsultationScreenState();
}

class _MyConsultationScreenState extends State<MyConsultationScreen> {
  /// GetMyConsultationsCubit
  late final GetMyConsultationsCubit _getMyConsultationsCubit;

  /// consultationsList
  final List<ConsultationEntity> consultationsList = [];

  /// ScrollController
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // init _getMyConsultationsCubit
    _getMyConsultationsCubit = getItInstance<GetMyConsultationsCubit>();

    // fetch myConsultations
    _fetchMyConsultationsList();

    // list on scroll controller
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _getMyConsultationsCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getMyConsultationsCubit,
      child: Scaffold(
        /// appbar
        appBar: AppBar(
          title: const Text("استشاراتى القانونية"),
        ),

        /// body
        body: BlocListener<GetMyConsultationsCubit, GetMyConsultationsState>(
          listener: (context, state) {
            //==> MyConsultationsListFetchedSuccessfully
            if (state is MyConsultationsListFetchedSuccessfully) {
              consultationsList.addAll(state.consultationsList);
            }
            //==> lastPageFetched
            if (state is LastPageMyConsultationsListFetched) {
              consultationsList.addAll(state.consultationsList);
            }
          },
          child: Column(
            children: [
              const AdsWidget(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: Sizes.dimen_16.h,
                      bottom: AppUtils.mainPagesVerticalPadding.h,
                      right: AppUtils.mainPagesHorizontalPadding.w,
                      left: AppUtils.mainPagesHorizontalPadding.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title with add new sos
                      TitleWithAddNewItem(
                        title: "استشاراتى القانونية",
                        addText: "اضف استشارة جديدة",
                        onAddPressed: () => _navigateToAddConsultation(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.dimen_10.h),
                        child: BlocBuilder<GetMyConsultationsCubit,
                            GetMyConsultationsState>(builder: (_, state) {
                          //==> loading
                          if (state is LoadingGetMyConsultationsList) {
                            return const Center(
                              child: LoadingWidget(),
                            );
                          }

                          //==> unAuthorized
                          if (state is UnAuthorizedGetMyConsultationsList) {
                            return Center(
                              child: AppErrorWidget(
                                appTypeError: AppErrorType.unauthorizedUser,
                                buttonText: "تسجيل الدخول",
                                onPressedRetry: () => _navigateToLogin(),
                              ),
                            );
                          }

                          //==> notActivatedUser
                          if (state
                              is NotActivatedUserToGetMyConsultationsList) {
                            return Center(
                              child: AppErrorWidget(
                                appTypeError: AppErrorType.notActivatedUser,
                                buttonText: "تواصل معنا",
                                onPressedRetry: () => _navigateToContactUs(),
                              ),
                            );
                          }

                          //==> notActivatedUser
                          if (state is ErrorWhileGettingMyConsultationsList) {
                            return Center(
                              child: AppErrorWidget(
                                appTypeError: state.appError.appErrorType,
                                onPressedRetry: () =>
                                    _fetchMyConsultationsList(),
                              ),
                            );
                          }

                          //==> empty
                          if (state is EmptyMyConsultationsList) {
                            return Center(
                              child: Text(
                                "ليس لديك استشارات قانونية",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColor.primaryDarkColor,
                                    ),
                              ),
                            );
                          }

                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: consultationsList.length + 1,
                            separatorBuilder: (context, index) => SizedBox(
                              height: Sizes.dimen_2.h,
                            ),
                            itemBuilder: (context, index) {
                              /// sos item
                              if (index < consultationsList.length) {
                                return MyConsultationItem(
                                  consultationEntity: consultationsList[index],
                                );
                              }

                              /// loading or end of list
                              return LoadingMoreMyConsultationsWidget(
                                myConsultationsCubit: _getMyConsultationsCubit,
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _fetchMyConsultationsList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyConsultationsCubit.fetchMyConsultationsList(
      userToken: userToken,
      currentListLength: consultationsList.length,
      offset: consultationsList.length,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// to navigate to create consultation
  void _navigateToAddConsultation() =>
      RouteHelper().requestAConsultation(context);

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getMyConsultationsCubit.state
            is! LastPageMyConsultationsListFetched) {
          _fetchMyConsultationsList();
        }
      }
    });
  }
}
