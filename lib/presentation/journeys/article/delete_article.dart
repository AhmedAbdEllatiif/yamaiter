import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/domain/entities/screen_arguments/delete_article_args.dart';
import 'package:yamaiter/presentation/logic/cubit/delete_article/delete_article_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../common/enum/app_error_type.dart';
import '../../../router/route_helper.dart';
import '../../widgets/app_error_widget.dart';

class DeleteArticleScreen extends StatefulWidget {
  final DeleteArticleArguments deleteArticleArguments;

  const DeleteArticleScreen({Key? key, required this.deleteArticleArguments})
      : super(key: key);

  @override
  State<DeleteArticleScreen> createState() => _DeleteArticleScreenState();
}

class _DeleteArticleScreenState extends State<DeleteArticleScreen> {
  late final DeleteArticleCubit _deleteArticleCubit;

  @override
  void initState() {
    super.initState();
    _deleteArticleCubit = widget.deleteArticleArguments.deleteArticleCubit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<DeleteArticleCubit, DeleteArticleState>(
        bloc: _deleteArticleCubit,
        listener: (_, state) {
          /// back of success
          if (state is ArticleDeletedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: AppColor.primaryDarkColor,
          width: double.infinity,
          padding: EdgeInsets.only(top: ScreenUtil.screenHeight * 0.25),
          child: BlocBuilder<DeleteArticleCubit, DeleteArticleState>(
            bloc: _deleteArticleCubit,
            builder: (context, state) {
              /// UnAuthorizedCreateSos
              if (state is NotFoundDeleteArticle) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.notFound,
                    message: "حدث خطأ",
                    buttonText: "اعد المحاولة",
                    onPressedRetry: () {
                      _deleteArticle();
                    },
                  ),
                );
              }

              /// UnAuthorized
              if (state is UnAuthorizedDeleteArticle) {
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
              if (state is NotActivatedUserToDeleteArticle) {
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
                    "حذف المنشور",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  /// space
                  SizedBox(height: Sizes.dimen_8.h),

                  Text(
                    "هل انت متاكد من حذف هذا المنشور",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  /// space
                  SizedBox(height: Sizes.dimen_8.h),

                  /// buttons or loading
                  _changeBetweenButtonsAndLoading(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// to send delete article request
  void _deleteArticle() {
    // init userToken
    final userToken = widget.deleteArticleArguments.userToken;

    // init id
    final articleId = widget.deleteArticleArguments.articleId;

    _deleteArticleCubit.deleteArticle(articleId: articleId, token: userToken);
  }

  /// to change view according tp state
  Widget _changeBetweenButtonsAndLoading(DeleteArticleState state) {
    /// loading
    if (state is LoadingDeleteArticle) {
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
              text: "احذف المنشور",
              color: AppColor.accentColor,
              textColor: AppColor.white,
              fontSize: Sizes.dimen_16.sp,
              padding: EdgeInsets.zero,
              onPressed: () => _deleteArticle(),
            ),
          ),
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
