import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/invite_lawyer/my_tasks_drop_down.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/screen_arguments/invite_lawyer_args.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';

class InviteLawyerScreen extends StatefulWidget {
  final InviteLawyerArguments inviteLawyerArguments;

  const InviteLawyerScreen({
    Key? key,
    required this.inviteLawyerArguments,
  }) : super(key: key);

  @override
  State<InviteLawyerScreen> createState() => _InviteLawyerScreenState();
}

class _InviteLawyerScreenState extends State<InviteLawyerScreen> {
  late final GetMyTasksCubit _getMyTasksCubit;

  String chosenTask = "";
  String? errorText;

  @override
  void initState() {
    super.initState();
    _getMyTasksCubit = getItInstance<GetMyTasksCubit>();

    _fetchMyTaskTitle();
  }

  @override
  void dispose() {
    _getMyTasksCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getMyTasksCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: Container(
          padding: EdgeInsets.only(
            top: ScreenUtil.screenHeight * 0.10,
            right: AppUtils.mainPagesHorizontalPadding.w,
            left: AppUtils.mainPagesHorizontalPadding.w,
          ),
          child: BlocBuilder<GetMyTasksCubit, GetMyTasksState>(
            builder: (context, state) {
              return Column(
                children: [
                  /// title
                  Text(
                    "دعوة لتنفيذ مهمة",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  /// space
                  if (state is OnlyNames)
                    if (state.names.isNotEmpty)
                      SizedBox(
                        height: Sizes.dimen_10.h,
                      ),

                  ///  dropDown
                  MyTasksDropDown(
                    getMyTasksCubit: _getMyTasksCubit,
                    errorText: errorText,
                    onChanged: (value) {
                      if (value != null) {
                        chosenTask = value;
                        _showOrHideError(false);
                      }
                    },
                  ),

                  /// space
                  SizedBox(
                    height: Sizes.dimen_10.h,
                  ),

                  /// add task text button
                  AppButton(
                    text: "اضف مهمة جديدة من هنا",
                    isTextButton: true,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                    onPressed: () => _navigateToCreateTask(),
                  ),

                  /// space
                  SizedBox(
                    height: Sizes.dimen_10.h,
                  ),

                  /// send invitation
                  AppButton(
                    text: "ارسال الدعوة",
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: AppUtils.mainPagesHorizontalPadding.w),
                    color: AppColor.accentColor,
                    textColor: AppColor.white,
                    onPressed: () {
                      if (_validate()) {
                        print("Sending an invitation");
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (chosenTask.isNotEmpty) return true;
    _showOrHideError(true);
    return false;
  }

  /// to hide to show error text
  void _showOrHideError(bool isShow) {
    setState(() {
      errorText = isShow ? "اختر مهمة من المهام" : null;
    });
  }

  /// to fetch tasks titles only
  void _fetchMyTaskTitle() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMyTasksCubit.fetchMyTasksList(
        userToken: userToken,
        taskType: TaskType.todo,
        currentListLength: 0,
        fetchOnlyNames: true);
  }

  /// to navigate to create task screen
  void _navigateToCreateTask() {
    RouteHelper().createTask(context);
  }
}
