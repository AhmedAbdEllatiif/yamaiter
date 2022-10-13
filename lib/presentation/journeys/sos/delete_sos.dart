import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_sos/delete_sos_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';

import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/screen_arguments/delete_sos_args.dart';
import '../../../router/route_helper.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class DeleteSosScreen extends StatefulWidget {
  final DeleteSosArguments deleteSosArguments;

  const DeleteSosScreen({Key? key, required this.deleteSosArguments})
      : super(key: key);

  @override
  State<DeleteSosScreen> createState() => _DeleteSosScreenState();
}

class _DeleteSosScreenState extends State<DeleteSosScreen> {
  late final DeleteSosCubit _deleteSosCubit;
  late final int _sosId;
  late final String _userToken;

  @override
  void initState() {
    super.initState();
    _deleteSosCubit = widget.deleteSosArguments.deleteSosCubit;
    _sosId = widget.deleteSosArguments.sosId;
    _userToken = widget.deleteSosArguments.userToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<DeleteSosCubit, DeleteSosState>(
        bloc: _deleteSosCubit,
        listener: (context, state) {
          /// back of success
          if (state is SosDeletedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: AppColor.primaryDarkColor,
          width: double.infinity,
          padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.25),
          child: BlocBuilder<DeleteSosCubit, DeleteSosState>(
            bloc: _deleteSosCubit,
            builder: (context, state) {
              /// UnAuthorizedCreateSos
              if (state is NotFoundDeleteSos) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notFound,
                    message: "حدث خطأ",
                    buttonText: "اعد المحاولة",
                    onPressedRetry: () {
                      _deleteSos();
                    },
                  ),
                );
              }

              /// UnAuthorized
              if (state is UnAuthorizedDeleteSos) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () {
                      _navigateToLogin();
                    },
                  ),
                );
              }

              /// NotActivatedUser
              if (state is NotActivatedUserToDeleteSos) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    message:
                        "نأسف لذلك، لم يتم تفعيل حسابك سوف تصلك رسالة بريدية عند التفعيل",
                    onPressedRetry: () {
                      _navigateToContactUs();
                    },
                  ),
                );
              }

              return Column(
                children: [
                  /// title
                  Text(
                    "حذف الاستغاثة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  Text(
                    "هل انت متاكد من حذف هذه الاستغاثة",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  _changeBetweenButtonsAndLoading(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// to send delete article request
  void _deleteSos() =>
      _deleteSosCubit.deleteSos(sosId: _sosId, token: _userToken);

  /// to change view according tp state
  Widget _changeBetweenButtonsAndLoading(DeleteSosState state) {
    /// loading
    if (state is LoadingDeleteSos) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: AppButton(
            text: "حذف الاستغاثة",
            color: AppColor.accentColor,
            textColor: AppColor.white,
            fontSize: Sizes.dimen_16.sp,
            padding: EdgeInsets.zero,
            onPressed: () => _deleteSos(),
          )),
          SizedBox(
            width: Sizes.dimen_10.w,
          ),
          Expanded(
            child: AppButton(
              text: "إلغاء",
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
