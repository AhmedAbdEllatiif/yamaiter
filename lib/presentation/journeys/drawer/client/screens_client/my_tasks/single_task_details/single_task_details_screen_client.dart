import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/single_task_details/applicant_lawyers/list_of_applicant_lawyers.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_single_task/get_my_single_task_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_content_title_widget.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../domain/entities/screen_arguments/single_task_client_args.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../../../../logic/client_cubit/assign_task/assign_task_client_cubit.dart';
import '../../../../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../../../../widgets/app_error_widget.dart';
import '../../../../../../widgets/loading_widget.dart';
import '../../../../../../widgets/text_with_icon.dart';

class SingleTaskScreenClient extends StatefulWidget {
  final SingleTaskClientArguments arguments;

  const SingleTaskScreenClient({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SingleTaskScreenClient> createState() => _SingleTaskScreenClientState();
}

class _SingleTaskScreenClientState extends State<SingleTaskScreenClient> {
  late final GetMySingleTaskCubit _getMySingleTaskCubit;
  late final AssignTaskClientCubit _assignTaskClientCubit;

  @override
  void initState() {
    super.initState();
    _getMySingleTaskCubit = getItInstance<GetMySingleTaskCubit>();
    _assignTaskClientCubit = widget.arguments.assignTaskClientCubit;
    _fetchMySingleTask();
  }

  @override
  void dispose() {
    _getMySingleTaskCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getMySingleTaskCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("تفاصيل المهمة"),
        ),

        /// body
        body: BlocListener<AssignTaskClientCubit, AssignTaskClientState>(
          bloc: _assignTaskClientCubit,
          listener: (context, state) {
            if (state is TaskClientAssignedSuccessfully) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<GetMySingleTaskCubit, GetMySingleTaskState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetMySingleTask) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedGetMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unauthorizedUser,
                    buttonText: "تسجيل الدخول",
                    onPressedRetry: () => _navigateToLogin(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is NotActivatedGetMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notActivatedUser,
                    buttonText: "تواصل معنا",
                    onPressedRetry: () => _navigateToContactUs(),
                  ),
                );
              }

              //==> notActivatedUser
              if (state is ErrorWhileGettingMySingleTask) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () => _fetchMySingleTask(),
                  ),
                );
              }

              //==> fetched
              if (state is MySingleTaskFetchedSuccessfully) {
                final taskEntity = state.taskEntity;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ScrollableAppCard(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// title
                          Row(
                            children: [
                              Expanded(
                                  child: AppContentTitleWidget(
                                title: taskEntity.title,
                                textSpace: 1.3,
                              )),
                              PopupMenuButton(
                                  // add icon, by default "3 dot" icon
                                  // icon: Icon(Icons.book)
                                  itemBuilder: (context) {
                                return [
                                  const PopupMenuItem<int>(
                                    value: 0,
                                    child: Text("تعديل المهمة"),
                                  ),
                                  const PopupMenuItem<int>(
                                    value: 1,
                                    child: Text("حذف المهمة"),
                                  ),
                                ];
                              }, onSelected: (value) {
                                if (value == 0) {
                                  print("My account menu is selected.");
                                } else if (value == 1) {
                                  print("Settings menu is selected.");
                                } else if (value == 2) {
                                  print("Logout menu is selected.");
                                }
                              }),
                            ],
                          ),

                          /// date, court, applicants
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 3, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /// court
                                Flexible(
                                  child: TextWithIconWidget(
                                    iconData: Icons.pin_drop_outlined,
                                    text: taskEntity.governorates,
                                  ),
                                ),

                                SizedBox(width: Sizes.dimen_8.w),

                                /// date
                                Flexible(
                                  child: TextWithIconWidget(
                                    iconData: Icons.date_range_outlined,
                                    text: taskEntity.startingDate,
                                  ),
                                ),

                                SizedBox(width: Sizes.dimen_8.w),

                                /// applicantsCount
                                TextWithIconWidget(
                                  iconData: Icons.person_outline_outlined,
                                  text: taskEntity.applicantsCount.toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// child
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //==> description
                          Text(
                            taskEntity.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black, height: 1.4),
                          ),

                          //==> space
                          SizedBox(
                            height: Sizes.dimen_10.h,
                          ),

                          ListOfApplicantLawyers(
                            assignTaskClientCubit: _assignTaskClientCubit,
                            taskId: taskEntity.id,
                            applicants: taskEntity.applicantLawyers,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }

              //==> else
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  /// To fetch my single task details
  void _fetchMySingleTask() {
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getMySingleTaskCubit.fetchMySingleTask(
      userToken: userToken,
      taskId: widget.arguments.taskId,
    );
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
