import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/task/task_form.dart';
import 'package:yamaiter/presentation/logic/cubit/accept_terms/accept_terms_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/create_task/create_task_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/get_accept_terms/get_accept_terms_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/enum/app_error_type.dart';
import '../../../domain/entities/screen_arguments/create_task_args.dart';
import '../../../router/route_helper.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/accept_terms_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class CreateTaskScreen extends StatefulWidget {
  final CreateTaskArguments? createTaskArguments;

  const CreateTaskScreen({Key? key, this.createTaskArguments})
      : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late final GetAcceptTermsCubit _getAcceptTermsCubit;
  late final AcceptTermsCubit _acceptTermsCubit;
  CreateTaskCubit? _createTaskCubit;
  bool isBackAfterSuccess =  false;

  @override
  void initState() {
    super.initState();

    // init GetAcceptTermsCubit
    _getAcceptTermsCubit = getItInstance<GetAcceptTermsCubit>();
    _acceptTermsCubit = getItInstance<AcceptTermsCubit>();
    if (widget.createTaskArguments != null) {
      _createTaskCubit = widget.createTaskArguments!.createTaskCubit;
      isBackAfterSuccess = widget.createTaskArguments!.goBackAfterSuccess;
    }

    // fetch terms
    _fetchTermsToAccept();
  }

  @override
  void dispose() {
    _getAcceptTermsCubit.close();
    _acceptTermsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getAcceptTermsCubit),
        BlocProvider(create: (context) => _acceptTermsCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// AcceptTermsCubit
          BlocListener<AcceptTermsCubit, AcceptTermsState>(
              listener: (_, state) {
            /// accepted successfully
            if (state is TermsAcceptedSuccessfully) {
              _fetchTermsToAccept();
            }
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("نشر مهمة عمل"),
          ),
          body: Column(
            children: [
              const AdsWidget(),

              //==> Task form
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppUtils.mainPagesHorizontalPadding.w,
                  //vertical: AppUtils.mainPagesVerticalPadding.h,
                ),
                child: BlocBuilder<GetAcceptTermsCubit, GetAcceptTermsState>(
                  builder: (context, state) {
                    /// loading
                    if (state is LoadingGetAcceptTerms) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    /// UnAuthorizedGetAcceptTerms
                    if (state is UnAuthorizedGetAcceptTerms) {
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
                    if (state is NotActivatedUserToGetAcceptTerms) {
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
                    if (state is ErrorWhileGettingAcceptTerms) {
                      return Center(
                        child: AppErrorWidget(
                          appTypeError: state.appError.appErrorType,
                          onPressedRetry: () {
                            _fetchTermsToAccept();
                          },
                        ),
                      );
                    }

                    /// NotAcceptedYet
                    if (state is TermsNotAcceptedYet) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: AcceptTermsWidget(
                          acceptTermsCubit: _acceptTermsCubit,
                          acceptTermsEntity: state.acceptTermsEntity,
                        ),
                      );
                    }

                    /// AlreadyAccepted
                    if (state is TermsAlreadyAccepted) {
                      return TaskForm(
                        createTaskCubit: _createTaskCubit,
                        onSuccess: () {
                          if (isBackAfterSuccess) {
                            Navigator.pop(context);
                          } else {
                            _navigateMyTasksScreen(context);
                          }
                        },
                      );
                    }

                    /// else
                    return const SizedBox.shrink();
                  },
                ),
              )),
            ],
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

  /// navigate to myTask screen
  void _navigateMyTasksScreen(BuildContext context) =>
      RouteHelper().myTasks(context, isReplacement: true);

  void _fetchTermsToAccept() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getAcceptTermsCubit.getAcceptTerms(token: userToken);
  }
}
