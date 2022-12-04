import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../../../common/constants/app_utils.dart';
import '../../../../../../../common/constants/sizes.dart';
import '../../../../../../../common/enum/app_error_type.dart';
import '../../../../../../../router/route_helper.dart';
import '../../../domain/entities/screen_arguments/end_task_client_args.dart';
import '../../logic/client_cubit/end_task_client/end_task_client_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_content_title_widget.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class EndTaskScreenClient extends StatefulWidget {
  final EndTaskClientArguments endTaskClientArguments;

  const EndTaskScreenClient({Key? key, required this.endTaskClientArguments})
      : super(key: key);

  @override
  State<EndTaskScreenClient> createState() => _EndTaskScreenClientState();
}

class _EndTaskScreenClientState extends State<EndTaskScreenClient> {
  late double _rating = 1;

  late final int _taskId;

  /// EndTaskCubit
  late final EndTaskClientCubit _endTaskClientCubit;

  @override
  void initState() {
    super.initState();
    _endTaskClientCubit = widget.endTaskClientArguments.endTaskClientCubit;
    _taskId = widget.endTaskClientArguments.taskId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      /// body
      body: BlocListener<EndTaskClientCubit, EndTaskClientState>(
        bloc: _endTaskClientCubit,
        listener: (context, state) {
          if (state is TaskClientEndedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_10.h,
            horizontal: AppUtils.screenHorizontalPadding.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //==>  title
              AppContentTitleWidget(
                title: "انهاء المهمة",
                textStyle: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppColor.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              //==> space
              SizedBox(height: Sizes.dimen_8.h),

              //==> subtitle
              Text(
                "قم بالتأكيد على سداد قيمة المهمة و تقييم المحامى",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColor.white),
              ),

              //==> space
              SizedBox(height: Sizes.dimen_8.h),

              //==> rating
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppUtils.cornerRadius.w),
                    border: Border.all(
                      color: _rating > 0 ? Colors.transparent : AppColor.red,
                    )),
                child: RatingBar.builder(
                  initialRating: 1,
                  minRating: 0,
                  //itemSize: iconRateSize.w,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  unratedColor: AppColor.primaryColor,
                  //ignoreGestures: true,
                  glowColor: AppColor.accentColor,
                  itemBuilder: (context, value) {
                    return const Icon(
                      Icons.star,
                      color: AppColor.accentColor,
                    );
                  },

                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),

              //==> space
              SizedBox(height: Sizes.dimen_8.h),

              //==> buttons
              BlocBuilder<EndTaskClientCubit, EndTaskClientState>(
                bloc: _endTaskClientCubit,
                builder: (context, state) {
                  //==> loading
                  if (state is LoadingEndTaskClient) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }

                  //==> unAuthorized
                  if (state is UnAuthorizedEndTaskClient) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.unauthorizedUser,
                        buttonText: "تسجيل الدخول",
                        onPressedRetry: () => _navigateToLogin(),
                      ),
                    );
                  }

                  //==> notActivatedUser
                  if (state is NotActivatedUserToEndTaskClient) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.notActivatedUser,
                        buttonText: "تواصل معنا",
                        onPressedRetry: () => _navigateToContactUs(),
                      ),
                    );
                  }

                  //==> error
                  if (state is ErrorWhileEndingTaskClient) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: state.appError.appErrorType,
                        onPressedRetry: () => _endTask(),
                      ),
                    );
                  }

                  //==> TaskNotFound
                  if (state is TaskNotFound) {
                    return Center(
                      child: AppErrorWidget(
                        appTypeError: AppErrorType.idNotFound,
                        onPressedRetry: () => _endTask(),
                      ),
                    );
                  }

                  // else
                  return Row(
                    children: [
                      Expanded(
                          child: AppButton(
                        text: "تأكيد السداد",
                        color: AppColor.accentColor,
                        textColor: AppColor.white,
                        fontSize: Sizes.dimen_16.sp,
                        padding: EdgeInsets.zero,
                        onPressed: () => _endTask(),
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
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// end task
  void _endTask() {
    if (_validateRating()) {
      // init userToken
      final userToken = context.read<UserTokenCubit>().state.userToken;

      // send end task
      _endTaskClientCubit.endTaskClient(
        userToken: userToken,
        taskId: _taskId,
        rating: _rating,
      );
    }
  }

  /// validate rating
  /// return true if the rating greater than zero
  bool _validateRating() {
    return _rating > 0.0;
  }

  /// To navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// To navigate to contactUs
  void _navigateToContactUs() => RouteHelper().chooseUserType(context);
}
