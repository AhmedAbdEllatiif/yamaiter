import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/widgets/app_refersh_indicator.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../domain/entities/data/sos_entity.dart';
import '../../../../router/route_helper.dart';
import '../../../logic/cubit/get_all_sos/get_all_soso_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/sos_item/sos_item.dart';
import 'loading_more_all_sos.dart';

class AllSosScreen extends StatefulWidget {
  final GetAllSosCubit getAllSosCubit;

  const AllSosScreen({Key? key, required this.getAllSosCubit})
      : super(key: key);

  @override
  State<AllSosScreen> createState() => _AllSosScreenState();
}

class _AllSosScreenState extends State<AllSosScreen> {
  late final GetAllSosCubit _getAllSosCubit;

  int offset = 0;

  final List<SosEntity> allSosList = [];

  // ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _getAllSosCubit = widget.getAllSosCubit;//getItInstance<GetAllSosCubit>();
    //_fetchMySosList();
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _getAllSosCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getAllSosCubit,
      child: BlocListener<GetAllSosCubit, GetAllSosState>(
        listener: (context, state) {
          //==> fetched
          if (state is AllSosListFetchedSuccessfully) {
            allSosList.addAll(state.sosEntityList);
          }
          //==> last page reached
          if (state is LastPageAllSosReached) {
            allSosList.addAll(state.sosEntityList);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            bottom: Sizes.dimen_2.h,
            left: Sizes.dimen_10.w,
            right: Sizes.dimen_10.w,
          ),
          child:
              BlocBuilder<GetAllSosCubit, GetAllSosState>(builder: (_, state) {
            //==> loading
            if (state is LoadingGetAllSosList) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            //==> unAuthorized
            if (state is UnAuthorizedGetAllSosList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.unauthorizedUser,
                  buttonText: "تسجيل الدخول",
                  onPressedRetry: () => _navigateToLogin(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is NotActivatedUserToGetAllSosList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: AppErrorType.notActivatedUser,
                  buttonText: "تواصل معنا",
                  onPressedRetry: () => _navigateToContactUs(),
                ),
              );
            }

            //==> notActivatedUser
            if (state is ErrorWhileGettingAllSosList) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchMySosList(),
                ),
              );
            }

            //==> empty
            if (state is EmptyAllSosList) {
              return Center(
                child: Text(
                  "لا يوجد استغاثات",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryDarkColor,
                      ),
                ),
              );
            }

            //==> fetched
            return AppRefreshIndicator(
              onRefresh: () async {
                allSosList.clear();
                _fetchMySosList();
              },
              child: ListView.separated(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: allSosList.length + 1,
                // controller: _controller,
                separatorBuilder: (context, index) => SizedBox(
                  height: Sizes.dimen_2.h,
                ),
                itemBuilder: (context, index) {
                  if (index < allSosList.length) {
                    return SosItem(
                      sosEntity: allSosList[index],
                      withCallLawyer: true,
                    );
                  }

                  /// loading or end of list
                  return LoadingMoreAllSosWidget(
                    allSosCubit: _getAllSosCubit,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  /// to fetch sos list
  void _fetchMySosList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAllSosCubit.fetchAllSosList(
      userToken: userToken,
      currentListLength: allSosList.length,
      offset: allSosList.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getAllSosCubit.state is! LastPageAllSosReached) {
          _fetchMySosList();
        }
      }
    });
  }

  /// to navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// to navigate to contact us
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
