import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_task_args.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../../../router/route_helper.dart';
import '../../logic/cubit/delete_task/delete_task_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class DeleteTaskScreen extends StatefulWidget {
  final DeleteTaskArguments deleteTaskArguments;

  const DeleteTaskScreen({Key? key, required this.deleteTaskArguments})
      : super(key: key);

  @override
  State<DeleteTaskScreen> createState() => _DeleteTaskScreenState();
}

class _DeleteTaskScreenState extends State<DeleteTaskScreen> {
  late final DeleteTaskCubit _deleteTaskCubit;
  late final int _taskId;

  @override
  void initState() {
    super.initState();
    _deleteTaskCubit = widget.deleteTaskArguments.deleteTaskCubit;
    _taskId = widget.deleteTaskArguments.taskId;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<DeleteTaskCubit, DeleteTaskState>(
        bloc: _deleteTaskCubit,
        listener: (context, state) {
          /// back of success
          if (state is TaskDeletedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: AppColor.primaryDarkColor,
          width: double.infinity,
          padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.25),
          child: BlocBuilder<DeleteTaskCubit, DeleteTaskState>(
            bloc: _deleteTaskCubit,
            builder: (context, state) {
              /// UnAuthorizedCreateTask
              if (state is NotFoundDeleteTask) {
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
              if (state is UnAuthorizedDeleteTask) {
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
              if (state is NotActivatedUserToDeleteTask) {
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
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

  /// to send delete task request
  void _deleteTask() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _deleteTaskCubit.deleteTask(taskId: _taskId, token: userToken);
  }


  /// to change view according tp state
  Widget _changeBetweenButtonsAndLoading(DeleteTaskState state) {
    /// loading
    if (state is LoadingDeleteTask) {
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
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
