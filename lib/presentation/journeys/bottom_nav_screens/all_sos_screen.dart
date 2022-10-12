import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/data/sos_entity.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/get_all_sos/get_all_soso_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/sos_item/sos_item.dart';

class AllSosScreen extends StatefulWidget {
  const AllSosScreen({Key? key}) : super(key: key);

  @override
  State<AllSosScreen> createState() => _AllSosScreenState();
}

class _AllSosScreenState extends State<AllSosScreen> {
  late final GetAllSosCubit _getAllSosCubit;

  final List<SosEntity> allSosList = [];

  @override
  void initState() {
    super.initState();
    _getAllSosCubit = getItInstance<GetAllSosCubit>();
    _fetchMySosList();
  }

  @override
  void dispose() {
    _getAllSosCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getAllSosCubit,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_10.h, horizontal: Sizes.dimen_10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// title with add new sos
            const AppContentTitleWidget(
              title: "نداءات الاستغاثة",
            ),

            /// list of my sos
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_3.h),
              child: BlocBuilder<GetAllSosCubit, GetAllSosState>(
                  builder: (_, state) {
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
                if (state is AllSosListFetchedSuccessfully) {
                  final fetchedList = state.sosEntityList;
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fetchedList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: Sizes.dimen_2.h,
                    ),
                    itemBuilder: (context, index) {
                      return SosItem(
                        sosEntity: fetchedList[index],
                        withCallLawyer: true,
                      );
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
          ],
        ),
      ),
    );
  }

  void _fetchMySosList() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAllSosCubit.fetchAllSosList(userToken: userToken,offset: allSosList.length);
  }

  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
