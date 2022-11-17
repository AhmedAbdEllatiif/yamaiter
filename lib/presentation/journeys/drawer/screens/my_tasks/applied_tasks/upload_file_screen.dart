import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/logic/cubit/upload_task_file/upload_task_file_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../../../common/constants/app_utils.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/app_error_type.dart';
import '../../../../../../common/screen_utils/screen_util.dart';
import '../../../../../../domain/entities/screen_arguments/upload_file_args.dart';
import '../../../../../../router/route_helper.dart';
import '../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../widgets/app_error_widget.dart';

class UploadFileScreen extends StatefulWidget {
  final UploadTaskFileArguments uploadTaskFileArguments;

  const UploadFileScreen({Key? key, required this.uploadTaskFileArguments})
      : super(key: key);

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  late final UploadTaskFileCubit _uploadTaskFileCubit;

  @override
  void initState() {
    super.initState();

    // init _uploadTaskFileCubit
    _uploadTaskFileCubit = widget.uploadTaskFileArguments.uploadTaskFileCubit ??
        getItInstance<UploadTaskFileCubit>();
  }

  @override
  void dispose() {
    /// only close if uploadTaskFileCubit not passed with arguments
    if (widget.uploadTaskFileArguments.uploadTaskFileCubit == null) {
      _uploadTaskFileCubit.close();
    }
    super.dispose();
  }

  String? pickedFilePath;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _uploadTaskFileCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: Container(
          color: AppColor.primaryDarkColor,
          width: double.infinity,
          padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.10),
          child: BlocConsumer<UploadTaskFileCubit, UploadTaskFileState>(
            bloc: _uploadTaskFileCubit,
            listener: (context, state) {
              if (state is TaskFiledUploadedSuccessfully) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              /// Error
              if (state is ErrorWhileUploadingTaskFile) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "اعد المحاولة",
                    onPressedRetry: () {
                      _uploadPickedFile();
                    },
                  ),
                );
              }

              /// UnAuthorized
              if (state is UnAuthorizedUploadTaskFile) {
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
              if (state is NotActivatedUserToUploadTaskFile) {
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
                    "ارفاق ملف المهمة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  /// Icon
                  Column(
                    children: [
                      Card(
                        shadowColor: pickedFilePath != null
                            ? AppColor.primaryColor
                            : AppColor.accentColor,
                        elevation: pickedFilePath != null ? 5 : 12,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(AppUtils.cornerRadius.w),
                          onTap: () => _pickAFile(),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.accentColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(
                                    AppUtils.cornerRadius.w)),
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file_outlined,
                                    color: pickedFilePath != null
                                        ? AppColor.accentColor
                                        : AppColor.primaryDarkColor,
                                    size: Sizes.dimen_80.w,
                                  ),
                                  Text(
                                    pickedFilePath != null
                                        ? "تم اختيار ملف"
                                        : "اختر الملف",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: pickedFilePath != null
                                              ? AppColor.accentColor
                                              : AppColor.primaryDarkColor,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (errorText != null)
                        Text(
                          errorText ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: AppColor.red),
                        )
                    ],
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  /// loading or buttons
                  state is LoadingUploadTaskFile
                      ? const LoadingWidget()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppUtils.mainPagesHorizontalPadding.w,
                          ),
                          child: Row(
                            //ainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppButton(
                                  text: 'ارسال الملف',
                                  padding: EdgeInsets.zero,
                                  color: AppColor.accentColor,
                                  textColor: AppColor.white,
                                  onPressed: () {
                                    if (_validateOnPickedFile()) {
                                      _uploadPickedFile();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: AppButton(
                                  text: 'الغاء',
                                  padding: EdgeInsets.zero,
                                  color: AppColor.primaryColor,
                                  textColor: AppColor.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
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

  /// to upload task file
  void _uploadPickedFile() {
    // userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // taskId
    final taskId = widget.uploadTaskFileArguments.taskId;

    // upload the file
    _uploadTaskFileCubit.uploadTaskFile(
      taskFilePath: pickedFilePath,
      taskId: taskId,
      token: userToken,
    );
  }

  /// To pick a file
  void _pickAFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //File file = File(result.files.single.path!);
      setState(() {
        pickedFilePath = result.files.single.path!;
        errorText = null;
      });
    } else {
      // User canceled the picker
      log("No file picked");
    }
  }

  /// return true if the picked file not null
  bool _validateOnPickedFile() {
    if (pickedFilePath != null) return true;

    setState(() {
      errorText = "* اختر ملف المهمة";
    });

    return false;
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
