import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../di/git_it_instance.dart';
import '../../../domain/entities/screen_arguments/apply_for_task_args.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/apply_for_task/apply_for_task_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_error_widget.dart';

class ApplyForTaskScreen extends StatefulWidget {
  final ApplyForTaskArguments applyForTaskArgument;

  const ApplyForTaskScreen({Key? key, required this.applyForTaskArgument})
      : super(key: key);

  @override
  State<ApplyForTaskScreen> createState() => _ApplyForTaskScreenState();
}

class _ApplyForTaskScreenState extends State<ApplyForTaskScreen> {
  /// ApplyForTaskCubit
  late final ApplyForTaskCubit _applyForTaskCubit;

  /// formKey
  final _formKey = GlobalKey<FormState>();

  /// cost controller
  final TextEditingController costController = TextEditingController();

  /// taskId
  late final TaskEntity _taskEntity;

  /// cost error text
  String? errorText;

  @override
  void initState() {
    super.initState();
    _applyForTaskCubit = widget.applyForTaskArgument.applyForTaskCubit ??
        getItInstance<ApplyForTaskCubit>();
    _taskEntity = widget.applyForTaskArgument.taskEntity;
  }

  @override
  void dispose() {
    if (widget.applyForTaskArgument.applyForTaskCubit == null) {
      _applyForTaskCubit.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _applyForTaskCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: Container(
          padding: EdgeInsets.only(
              top: ScreenUtil.screenHeight * 0.10, right: 20, left: 20),
          child: BlocConsumer<ApplyForTaskCubit, ApplyForTaskState>(
            bloc: _applyForTaskCubit,
            //==> listener
            listener: (context, state) {
              // success
              if (state is AppliedForTaskSuccessfully) {
                Navigator.pop(context);
              }
            },

            //==> builder
            builder: (context, state) {
              /// UnAuthorizedCreateSos
              if (state is ErrorWhileApplyingForTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    message: "حدث خطأ",
                    buttonText: "اعد المحاولة",
                    onPressedRetry: () {
                      _applyForTask();
                    },
                  ),
                );
              }

              /// UnAuthorized
              if (state is UnAuthorizedApplyForTask) {
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
              if (state is NotActivatedUserToApplyForTask) {
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

              if (state is AlreadyAppliedToThisTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.alreadyAppliedToThisTask,
                    message: "لقد تقدمت إلى هذه المهمة بالفعل",
                    buttonText: "العودة",
                    onPressedRetry: () {
                      _backToTaskDetailsScreen();
                    },
                  ),
                );
              }

              return Column(
                children: [
                  /// title
                  Text(
                    "تقدم لتنفيذ المهمة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  Form(
                    key: _formKey,
                    child: AppTextField(
                      controller: costController,
                      label: "حدد تكلفة المهمة",
                      errorText: errorText,
                      textInputType: TextInputType.number,
                      labelStyle:
                          Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  /// loading or the button
                  state is LoadingApplyForTask
                      ? const LoadingWidget()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes.dimen_30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: AppButton(
                                text: "تقدم للمهمة",
                                color: AppColor.accentColor,
                                textColor: AppColor.white,
                                fontSize: Sizes.dimen_16.sp,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (_formValidate()) {
                                    _applyForTask();
                                  }
                                },
                              )),
                              SizedBox(
                                width: Sizes.dimen_10.w,
                              ),
                              Expanded(
                                child: AppButton(
                                  text: "إلغاء",
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _backToTaskDetailsScreen();
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

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// to back to TaskDetailsScreen
  void _backToTaskDetailsScreen() {
    /* RouteHelper().taskDetails(
      context,
      taskDetailsArguments: TaskDetailsArguments(taskEntity: _taskEntity),
      isPushReplacement: true,
    );*/
    Navigator.pop(context);
  }

  /// to apply for task
  void _applyForTask() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    final cost = int.parse(costController.value.text);

    _applyForTaskCubit.applyForTask(
        cost: cost, taskId: _taskEntity.id, token: userToken);
  }

  /// to validate on the price
  bool _formValidate() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // current cost value
        final cost = costController.value.text;

        // try to parse current value to int
        if (int.tryParse(cost) == null) {
          setState(() {
            errorText = "سعر خطأ";
          });
          return false; // current value not an int
        }

        // here the cost is not null and is parse
        setState(() {
          errorText = null;
        });
        return true;
      }

      //==> return false (form.currentState.validate == false)
      setState(() {
        errorText = "مطلوب تحديد التكلفة";
      });
      return false;
    }

    //=> return false (_formKey.currentState is null)
    setState(() {
      errorText = "مطلوب تحديد التكلفة";
    });
    return false;
  }
}
