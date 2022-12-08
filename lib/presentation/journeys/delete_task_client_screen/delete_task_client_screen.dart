import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../domain/entities/screen_arguments/delete_task_client_args.dart';
import '../../logic/client_cubit/delete_task_client/delete_task_client_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class DeleteTaskClientScreen extends StatefulWidget {
  final DeleteTaskClientArguments deleteTaskClientArguments;

  const DeleteTaskClientScreen(
      {Key? key, required this.deleteTaskClientArguments})
      : super(key: key);

  @override
  State<DeleteTaskClientScreen> createState() => _DeleteTaskClientScreenState();
}

class _DeleteTaskClientScreenState extends State<DeleteTaskClientScreen> {
  late final DeleteTaskClientCubit _deleteTaskCubit;
  late final int _taskId;

  @override
  void initState() {
    super.initState();
    _deleteTaskCubit = widget.deleteTaskClientArguments.deleteTaskClientCubit;
    _taskId = widget.deleteTaskClientArguments.taskId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<DeleteTaskClientCubit, DeleteTaskClientState>(
        bloc: _deleteTaskCubit,
        listener: (context, state) {
          /// back of success
          if (state is TaskClientDeletedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: AppColor.primaryDarkColor,
          width: double.infinity,
          padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.25),
          child: BlocBuilder<DeleteTaskClientCubit, DeleteTaskClientState>(
            bloc: _deleteTaskCubit,
            builder: (context, state) {
              /// UnAuthorizedCreateTask
              if (state is NotFoundDeleteTaskClient) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notFound,
                    message: "حدث خطأ",
                    buttonText: "اعد المحاولة",
                    onPressedRetry: () {
                      _deleteTask();
                    },
                  ),
                );
              }

              /// UnAuthorized
              if (state is UnAuthorizedDeleteTaskClient) {
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
              if (state is NotActivatedUserToDeleteTaskClient) {
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
                    "حذف المهمة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  Text(
                    "هل انت متاكد من حذف هذه المهمة",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  /// loading or show button
                  state is LoadingDeleteTaskClient
                      ? const Center(
                          child: LoadingWidget(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes.dimen_30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: AppButton(
                                text: "حذف المهمة",
                                color: AppColor.accentColor,
                                textColor: AppColor.white,
                                fontSize: Sizes.dimen_16.sp,
                                padding: EdgeInsets.zero,
                                onPressed: () => _deleteTask(),
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
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// to send delete task request
  void _deleteTask() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _deleteTaskCubit.deleteTaskClient(taskId: _taskId, token: userToken);
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
