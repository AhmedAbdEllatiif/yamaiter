import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/cubit/decline_invited_task/decline_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../../../domain/entities/screen_arguments/decline_task_args.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../widgets/app_button.dart';
import '../../../../../../widgets/app_error_widget.dart';

class DeclineTaskScreen extends StatefulWidget {
  final DeclineTaskArguments arguments;

  const DeclineTaskScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<DeclineTaskScreen> createState() => _DeclineTaskScreenState();
}

class _DeclineTaskScreenState extends State<DeclineTaskScreen> {
  /// task id
  late final int _taskId;

  /// DeclineTaskCubit
  late final DeclineTaskCubit _declineTaskCubit;

  @override
  void initState() {
    super.initState();
    _taskId = widget.arguments.taskId;

    _declineTaskCubit =
        widget.arguments.declineTaskCubit ?? getItInstance<DeclineTaskCubit>();
  }

  @override
  void dispose() {
    _declineTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _declineTaskCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: BlocListener<DeclineTaskCubit, DeclineTaskState>(
          bloc: _declineTaskCubit,
          listener: (context, state) {
            if (state is TaskDeclinedSuccessfully) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: AppColor.primaryDarkColor,
              width: double.infinity,
              padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.15),
              child: BlocBuilder<DeclineTaskCubit, DeclineTaskState>(
                bloc: _declineTaskCubit,
                builder: (context, state) {
                  /// UnAuthorizedCreateSos
                  if (state is NotFoundDeclineTask) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.notFound,
                        message: "حدث خطأ",
                        buttonText: "اعد المحاولة",
                        onPressedRetry: () {
                          _declineTask();
                        },
                      ),
                    );
                  }

                  /// UnAuthorized
                  if (state is UnAuthorizedDeclineTask) {
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
                  if (state is NotActivatedUserToDeclineTask) {
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
                        "رفض المهمة",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColor.accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      SizedBox(
                        height: Sizes.dimen_8.h,
                      ),

                      Text(
                        "هل انت متاكد من رفض هذه المهمة",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      SizedBox(
                        height: Sizes.dimen_8.h,
                      ),

                      state is LoadingDeclineTask
                          ? const LoadingWidget()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.dimen_30.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: AppButton(
                                    text: "تأكيد الرفض",
                                    color: AppColor.accentColor,
                                    textColor: AppColor.white,
                                    fontSize: Sizes.dimen_16.sp,
                                    padding: EdgeInsets.zero,
                                    onPressed: () => _declineTask(),
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
        ),
      ),
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);

  /// To decline the task
  void _declineTask() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _declineTaskCubit.declineTask(
      taskId: _taskId,
      token: userToken,
    );
  }
}
