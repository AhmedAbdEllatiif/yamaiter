import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/tax_item.dart';
import 'package:yamaiter/presentation/logic/cubit/create_tax/create_tax_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_in_progress_taxes/get_in_progress_taxes_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/app_error_type.dart';
import '../../../../../router/route_helper.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../widgets/app_error_widget.dart';
import '../../../../widgets/loading_widget.dart';

class InProgressTaxesList extends StatefulWidget {
  final CreateTaxCubit createTaxCubit;

  const InProgressTaxesList(
      {Key? key,
      required this.createTaxCubit})
      : super(key: key);

  @override
  State<InProgressTaxesList> createState() => _InProgressTaxesListState();
}

class _InProgressTaxesListState extends State<InProgressTaxesList>
    with AutomaticKeepAliveClientMixin {
  late final GetInProgressTaxesCubit _inProgressTaxesCubit;

  @override
  void initState() {
    super.initState();
    _inProgressTaxesCubit = getItInstance<GetInProgressTaxesCubit>();
    _fetchInProgressTaxes();
  }

  @override
  void dispose() {
    _inProgressTaxesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _inProgressTaxesCubit,
      child: BlocListener<CreateTaxCubit, CreateTaxState>(
        listener: (context, state) {
          if (state is TaxCreatedSuccessfully) {
            _fetchInProgressTaxes();
          }
        },
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
              if (state is InProgressTaxesListFetchedSuccessfully) {
                final fetchedList = state.taxList;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.dimen_5.h, horizontal: Sizes.dimen_10.w),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fetchedList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: Sizes.dimen_2.h,
                    ),
                    itemBuilder: (context, index) {
                      return TaxItem(taxEntity: fetchedList[index]);
                    },
                  ),
                );
              }

              /// other
              return const SizedBox.shrink();
            },
          );
        }),
      ),
    );
  }

  /// to fetch in progress taxes
  void _fetchInProgressTaxes() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _inProgressTaxesCubit.fetchInProgressTaxesList(userToken: userToken);
  }

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contact us
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
