import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/app_error_type.dart';
import '../../../../../../di/git_it_instance.dart';
import '../../../../../../domain/entities/tax_entity.dart';
import '../../../../../../router/route_helper.dart';
import '../../../../../logic/cubit/get_completed_taxes/get_completed_taxes_cubit.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../tax_item.dart';
import 'loading_more_completed_taxes.dart';

class CompletedTaxesList extends StatefulWidget {
  const CompletedTaxesList({Key? key}) : super(key: key);

  @override
  State<CompletedTaxesList> createState() => _CompletedTaxesListState();
}

class _CompletedTaxesListState extends State<CompletedTaxesList>
    with AutomaticKeepAliveClientMixin {
  // GetCompletedTaxesCubit
  late final GetCompletedTaxesCubit _completedTaxesCubit;

  // taxesList
  final List<TaxEntity> taxesList = [];

  // ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    // init GetCompletedTaxesCubit
    _completedTaxesCubit = getItInstance<GetCompletedTaxesCubit>();

    // init controller
    _controller = ScrollController();
    _listenerOnScrollController();

    // fetch taxes list
    _fetchCompletedTaxes();
  }

  @override
  void dispose() {
    _completedTaxesCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _completedTaxesCubit,
      child: MultiBlocListener(
        listeners: [
          /// GetMySosCubit
          BlocListener<GetCompletedTaxesCubit, GetCompletedTaxesState>(
              listener: (context, state) {
            //==> MySosListFetchedSuccessfully
            if (state is CompletedTaxesListFetchedSuccessfully) {
              taxesList.addAll(state.taxList);
            }
            //==> lastPageFetched
            if (state is LastPageCompletedTaxesListFetched) {
              taxesList.addAll(state.taxList);
            }
          }),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<GetCompletedTaxesCubit, GetCompletedTaxesState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetCompletedTaxesList) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetCompletedTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedUserToGetCompletedTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingCompletedTaxesList) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchCompletedTaxes(),
                  ),
                );
              }

              //==> empty
              if (state is EmptyCompletedTaxesList) {
                return Center(
                  child: Text(
                    "ليس لديك اقرارات مكتملة",
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
                        isCompleted: true,
                      );
                    }

                    /// loading or end of list
                    return LoadingMoreCompletedTaxesWidget(
                      completedTaxesCubit: _completedTaxesCubit,
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }

  /// to fetch in progress taxes
  void _fetchCompletedTaxes() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _completedTaxesCubit.fetchCompletedTaxesList(
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
        if (_completedTaxesCubit.state is! LastPageCompletedTaxesListFetched) {
          _fetchCompletedTaxes();
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
