import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/tax_entity.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/tax_item.dart';
import 'package:yamaiter/presentation/logic/cubit/pay_for_tax/pay_for_tax_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_in_progress_taxes/get_in_progress_taxes_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/app_error_type.dart';
import '../../../../../../router/route_helper.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/app_refersh_indicator.dart';
import '../../../../../widgets/loading_widget.dart';
import 'loading_more_in_progress_taxes.dart';

class InProgressTaxesList extends StatefulWidget {
  final PayForTaxCubit createTaxCubit;

  const InProgressTaxesList({Key? key, required this.createTaxCubit})
      : super(key: key);

  @override
  State<InProgressTaxesList> createState() => _InProgressTaxesListState();
}

class _InProgressTaxesListState extends State<InProgressTaxesList>
    with AutomaticKeepAliveClientMixin {
  late final GetInProgressTaxesCubit _inProgressTaxesCubit;

  final List<TaxEntity> taxesList = [];
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    // init GetInProgressTaxesCubit
    _inProgressTaxesCubit = getItInstance<GetInProgressTaxesCubit>();

    // init controller
    _controller = ScrollController();
    _listenerOnScrollController();

    // fetch taxes list
    _fetchInProgressTaxes();
  }

  @override
  void dispose() {
    _inProgressTaxesCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _inProgressTaxesCubit,
      child: MultiBlocListener(
        listeners: [
          /// CreateTaxCubit
          BlocListener<PayForTaxCubit, PayForTaxState>(
              listener: (context, state) {
            if (state is TaxCreatedSuccessfully) {
              _fetchInProgressTaxes();
            }
          }),

          /// GetMySosCubit
          BlocListener<GetInProgressTaxesCubit, GetInProgressTaxesState>(
              listener: (context, state) {
            //==> MySosListFetchedSuccessfully
            if (state is InProgressTaxesListFetchedSuccessfully) {
              taxesList.addAll(state.taxList);
            }
            //==> lastPageFetched
            if (state is LastPageInProgressTaxesListFetched) {
              taxesList.addAll(state.taxList);
            }
          }),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<GetInProgressTaxesCubit, GetInProgressTaxesState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetInProgressTaxesList) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetInProgressTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedUserToGetInProgressTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingInProgressTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchInProgressTaxes(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyInProgressTaxesList) {
                return Center(
                  child: Text(
                    "ليس لديك اقرارات تحت التنفيذ",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.primaryDarkColor,
                        ),
                  ),
                );
              }

              /// fetched
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_5.h, horizontal: Sizes.dimen_10.w),
                child: AppRefreshIndicator(
                  onRefresh: ()async{
                    taxesList.clear();
                    _fetchInProgressTaxes();
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: taxesList.length + 1,
                    separatorBuilder: (context, index) => SizedBox(
                      height: Sizes.dimen_2.h,
                    ),
                    itemBuilder: (context, index) {
                      /// tax item
                      if (index < taxesList.length) {
                        return TaxItem(
                          taxEntity: taxesList[index],
                          isCompleted: false,
                        );
                      }

                      /// loading or end of list
                      return LoadingMoreInProgressTaxesWidget(
                        inProgressTaxesCubit: _inProgressTaxesCubit,
                      );
                    },
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  /// to fetch in progress taxes
  void _fetchInProgressTaxes() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _inProgressTaxesCubit.fetchInProgressTaxesList(
      userToken: userToken,
      offset: taxesList.length,
    );
  }

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contact us
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_inProgressTaxesCubit.state
            is! LastPageInProgressTaxesListFetched) {
          _fetchInProgressTaxes();
        }
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
