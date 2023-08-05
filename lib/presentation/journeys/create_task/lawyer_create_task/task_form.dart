import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/di/git_it_instance.dart';

import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';
import 'package:yamaiter/presentation/widgets/select_date.dart';
import 'package:yamaiter/presentation/widgets/text_field_large_container.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../logic/cubit/create_task/create_task_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../widgets/app_error_widget.dart';

class TaskForm extends StatefulWidget {
  final bool withWithCard;
  final Function() onSuccess;
  final CreateTaskCubit? createTaskCubit;

  const TaskForm(
      {Key? key,
      this.withWithCard = true,
      this.createTaskCubit,
      required this.onSuccess})
      : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final CreateTaskCubit _createTaskCubit;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String taskType = "";
  String governorate = "";
  String subGovernorate = "";

  @override
  void initState() {
    super.initState();
    _createTaskCubit =
        widget.createTaskCubit ?? getItInstance<CreateTaskCubit>();
  }

  @override
  void dispose() {
    if (widget.createTaskCubit == null) {
      _createTaskCubit.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _createTaskCubit,
      child: BlocListener<CreateTaskCubit, CreateTaskState>(
        bloc: _createTaskCubit,
        listener: (context, state) {
          //==> show snack bar with check internet connection
          if (state is ErrorWhileCreatingTask) {
            showSnackBar(context, message: "تحقق من اتصال الإنترنت");
          }

          //==> on success navigate to my Task screen
          if (state is TaskCreatedSuccessfully) {
            _navigateToMyTaskScreen();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppUtils.mainPagesHorizontalPadding.w,
            // vertical: AppUtils.mainPagesVerticalPadding.h,
          ),

          ///  card
          child: Padding(
            padding: const EdgeInsets.only(
                // top: Sizes.dimen_10.h,
                ),
            child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
              bloc: _createTaskCubit,
              builder: (context, state) {
                /// NotAcceptTermsToCreateTask
                if (state is NotAcceptTermsToCreateTask) {
                  return Center(
                    child: AppErrorWidget(
                      appTypeError: AppErrorType.notAcceptedYet,
                      buttonText: "الشروط",
                      message: "مازلت لم توافق على شروط الخصوصية بعد",
                      onPressedRetry: () {
                        // _navigateToLogin();
                      },
                    ),
                  );
                }

                /// UnAuthorizedCreateTask
                if (state is UnAuthorizedCreateTask) {
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

                /// NotActivatedUserToCreateTask
                if (state is NotActivatedUserToCreateTask) {
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

                if (widget.withWithCard) {
                  return ScrollableAppCard(
                    child: _form(state),
                  );
                }

                return _form(state);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(CreateTaskState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: widget.withWithCard
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          /// title
          AppContentTitleWidget(
            title: "نشر مهمة عمل",
            textColor:
                widget.withWithCard ? AppColor.primaryDarkColor : AppColor.white,
          ),

          //==> space
          SizedBox(height: Sizes.dimen_8.h),

          Form(
            key: _formKey,
            child: Column(
              children: [
                /*AppDropDownField(
                    hintText: "موضوع المهمة",
                    itemsList: taskTypeList,
                    onChanged: (value) {
                      if (value != null) {
                        taskType = value;
                      }
                    }),*/

                /// price
                AppTextField(
                  controller: titleController,
                  label: "موضوع المهمة",
                  minLength: 5,
                ),

                //==> space
                SizedBox(height: Sizes.dimen_5.h),

                AppDropDownField(
                    hintText: "نطاق التنفيذ",
                    itemsList: governoratesListWithSelectAll,
                    isLastItemHighlighted: true,
                    onChanged: (value) {
                      if (value != null) {
                        governorate = value;
                      }
                    }),

                //==> space
                SizedBox(height: Sizes.dimen_5.h),

                AppDropDownField(
                    hintText: "المحكمة الكلية المختصة بتنفيذ المهمة",
                    itemsList: subGovernoratesList,
                    isLastItemHighlighted: true,
                    onChanged: (value) {
                      if (value != null) {
                        subGovernorate = value;
                      }
                    }),

                //==> space
                SizedBox(height: Sizes.dimen_5.h),

                SelectDateWidget(
                    hasError: _selectDateError,
                    onDateSelected: (selectedDate) {
                      _selectedDate = selectedDate;
                    }),

                //==> space
                SizedBox(height: Sizes.dimen_5.h),

                /// price
                AppTextField(
                  controller: priceController,
                  textInputType: TextInputType.number,
                  label: "حدد مبلغ مكافئة التنفيذ",
                ),

                //==> space
                SizedBox(height: Sizes.dimen_5.h),

                TextFieldLargeContainer(
                  appTextField: AppTextField(
                    controller: descriptionController,
                    label: "اشرح تفاصيل المهمة هنا",
                    maxLines: 20,
                    withFocusedBorder: false,
                    minLength: 5,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ],
            ),
          ),

          //==> space
          SizedBox(height: Sizes.dimen_5.h),

          _switchLoadingAndButton(state),

          //==> space
          SizedBox(height: Sizes.dimen_20.h),
        ],
      ),
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(CreateTaskState state) {
    if (state is LoadingCreateTask) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "نشر المهمة",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isFormValid()) {
          _sendTask();
        }
      },
    );
  }

  /// to validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate() && _isDateValid();
    }
    return false;
  }

  bool _isDateValid() {
    if (_selectedDate == null) {
      setState(() {
        _selectDateError = true;
      });
      return false;
    }
    return true;
  }

  /// send Task
  void _sendTask() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init title
    final title = titleController.value.text;

    // init description
    final description = descriptionController.value.text;

    // init price
    final price = priceController.value.text;

    // send create Task request
    _createTaskCubit.sendTask(
      token: userToken,
      title: title,
      governorates: governorate,
      description: description.isNotEmpty ? description : "لا يوجد",
      price: price,
      court: subGovernorate,
      startingDate: _selectedDate ?? "",
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);

  /// navigate to my Task
  void _navigateToMyTaskScreen() {
    widget.onSuccess();
  }

  /// to select required date
  String? _selectedDate;

  bool _selectDateError = false;
}
