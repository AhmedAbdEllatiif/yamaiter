import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/edit_task_args.dart';
import 'package:yamaiter/presentation/logic/cubit/update_task/update_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';

import '../../../../../../../common/constants/drop_down_list.dart';
import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../widgets/app_button.dart';
import '../../../../../../widgets/app_drop_down_field.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/app_text_field.dart';
import '../../../../../../widgets/loading_widget.dart';
import '../../../../../../widgets/select_date.dart';
import '../../../../../../widgets/text_field_large_container.dart';

class EditTaskScreen extends StatefulWidget {
  final EditTaskArguments editTaskArguments;

  const EditTaskScreen({Key? key, required this.editTaskArguments})
      : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final UpdateTaskCubit _updateTaskCubit;

  late final TaskEntity _taskEntity;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  /// values to send
  late String taskTitle;
  late String governorate;
  late String subGovernorate;

  /// Initial values
  late final String? initialTitle;
  late final String? initialGovernorate;
  late final String? initialCourt;

  /// to select required date
  String? _selectedDate;
  bool _selectDateError = false;

  @override
  void initState() {
    super.initState();
    _updateTaskCubit = widget.editTaskArguments.updateTaskCubit ??
        getItInstance<UpdateTaskCubit>();
    _taskEntity = widget.editTaskArguments.taskEntity;
    _setInitialText();
  }

  @override
  void dispose() {
    // close only if the cubit argument is null
    if (widget.editTaskArguments.updateTaskCubit == null) {
      _updateTaskCubit.close();
    }
    super.dispose();
  }

  /// To init text with value of current task
  void _setInitialText() {
    priceController.text = _taskEntity.price.toString();
    descriptionController.text = _taskEntity.description;
    _selectedDate = _taskEntity.startingDate;
    initialTitle =
        taskTypeList.contains(_taskEntity.title) ? _taskEntity.title : null;

    initialGovernorate = governoratesList.contains(_taskEntity.governorates)
        ? _taskEntity.governorates
        : null;

    initialCourt = subGovernoratesList.contains(_taskEntity.court)
        ? _taskEntity.court
        : null;

    taskTitle = initialTitle ?? "";
    governorate = initialGovernorate ?? "";
    subGovernorate = initialCourt ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateTaskCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_10.h,
            horizontal: AppUtils.screenHorizontalPadding.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //==>  title
              AppContentTitleWidget(
                title: "تعديل المهمة",
                textStyle: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColor.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              //==> space
              SizedBox(height: Sizes.dimen_12.h),

              //==>  form
              BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
                bloc: _updateTaskCubit,
                //==> listener
                listener: (context, state) {
                  /// go back on successfully
                  if (state is TaskUpdatedSuccessfully) {
                    Navigator.pop(context);
                  }
                },

                //==> builder
                builder: (context, state) {
                  /// UnAuthorizedGetAcceptTerms
                  if (state is UnAuthorizedUpdateTask) {
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

                  /// NotActivatedUserToGetAcceptTerms
                  if (state is NotActivatedUserToUpdateTask) {
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

                  /// NotActivatedUserToGetAcceptTerms
                  if (state is ErrorWhileUpdatingTask) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: state.appError.appErrorType,
                        onPressedRetry: () {
                          _updateTask();
                        },
                      ),
                    );
                  }

                  return Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppDropDownField(
                                hintText: "موضوع المهمة",
                                initialValue: initialTitle,
                                itemsList: taskTypeList,
                                onChanged: (value) {
                                  if (value != null) {
                                    taskTitle = value;
                                  }
                                }),

                            //==> space
                            SizedBox(height: Sizes.dimen_5.h),

                            AppDropDownField(
                                hintText: "نطاق التنفيذ",
                                initialValue: initialGovernorate,
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
                                hintText:
                                    "المحكمة الكلية المختصة بتنفيذ المهمة",
                                initialValue: initialCourt,
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
                                initialValue: _taskEntity.startingDate,
                                hasError: _selectDateError,
                                onDateSelected: (selectedDate) {
                                  _selectedDate = selectedDate;
                                }),

                            //==> space
                            SizedBox(height: Sizes.dimen_5.h),

                            /// price
                            AppTextField(
                              controller: priceController,
                              enabled: false,
                              textStyle: const TextStyle(
                                  color: AppColor.primaryDarkColor),
                              label: "",
                            ),

                            //==> space
                            SizedBox(height: Sizes.dimen_5.h),

                            TextFieldLargeContainer(
                              appTextField: AppTextField(
                                controller: descriptionController,
                                label: "اشرح تفاصيل المهمة هنا",
                                maxLines: 20,
                                withFocusedBorder: false,
                                textInputType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                              ),
                            ),

                            //==> space
                            SizedBox(height: Sizes.dimen_5.h),

                            _switchLoadingAndButton(state),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(UpdateTaskState state) {
    if (state is LoadingUpdateTask) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "تعديل المهمة",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isFormValid()) {
          _updateTask();
        }
      },
    );
  }

  /// send Task
  void _updateTask() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init description
    final description = descriptionController.value.text;

    // init price
    final price = priceController.value.text;

    // send update Task request
    _updateTaskCubit.updateTask(
      id: _taskEntity.id,
      token: userToken,
      title: taskTitle,
      governorates: governorate,
      description: description.isNotEmpty ? description : "لا يوجد",
      price: price,
      court: subGovernorate,
      startingDate: _selectedDate ?? "لا يوجد",
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

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
