import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/data/article_entity.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/common_functions.dart';
import '../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../logic/cubit/update_article/update_article_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_content_title_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scrollable_app_card.dart';
import '../../../widgets/text_field_large_container.dart';
import '../../reigster_lawyer/upload_id_image.dart';

class UpdateArticleForm extends StatefulWidget {
  final bool withWithCard;
  final Function() onSuccess;
  final UpdateArticleCubit updateArticleCubit;
  final String userToken;
  final ArticleEntity articleEntity;

  const UpdateArticleForm({
    Key? key,
    this.withWithCard = true,
    required this.onSuccess,
    required this.updateArticleCubit,
    required this.userToken,
    required this.articleEntity,
  }) : super(key: key);

  @override
  State<UpdateArticleForm> createState() => _UpdateArticleFormState();
}

class _UpdateArticleFormState extends State<UpdateArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// imagerPicker cubit
  late final PickImageCubit _pickImageCubit;

  /// CreateArticleCubit
  late final UpdateArticleCubit _updateArticleCubit;

  final List<String> _imagesPicked = [];

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
    _updateArticleCubit = widget.updateArticleCubit;

    //==> init controller texts
    titleController.text = widget.articleEntity.title;
    descriptionController.text = widget.articleEntity.description;
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    _updateArticleCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _pickImageCubit),
          BlocProvider(create: (context) => _updateArticleCubit),
        ],
        child: MultiBlocListener(
          listeners: [
            /// PickImageCubit
            BlocListener<PickImageCubit, PickImageState>(
              listener: (context, state) {
                if (state is MultiImagesPicked) {
                  if (state.multiImages != null) {
                    _imagesPicked.addAll(state.multiImages!);
                  }
                }
              },
            ),

            /// CreateArticleCubit
            BlocListener<UpdateArticleCubit, UpdateArticleState>(
              listener: (context, state) {
                //==> show snack bar with check internet connection
                if (state is ErrorWhileUpdatingArticle) {
                  showSnackBar(context,
                      backgroundColor: AppColor.accentColor,
                      textColor: AppColor.primaryDarkColor,
                      isFloating: false,
                      message: "تحقق من اتصال الإنترنت");
                }

                //==> on success navigate to my sos screen
                if (state is ArticleUpdatedSuccessfully) {
                  _navigateToMyArticlesScreen();
                }
              },
            )
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppUtils.mainPagesHorizontalPadding.w,
                vertical: AppUtils.mainPagesVerticalPadding.h),
            child: Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_10.h),
              child: BlocBuilder<UpdateArticleCubit, UpdateArticleState>(
                  builder: (context, state) {
                /// UnAuthorizedCreateSos
                if (state is UnAuthorizedUpdateArticle) {
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

                /// NotActivatedUserToCreateSos
                if (state is NotActivatedUserToUpdateArticle) {
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

                return widget.withWithCard
                    ? ScrollableAppCard(
                        child: _form(state),
                      )
                    : _form(state);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(UpdateArticleState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: widget.withWithCard
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          /// title
          AppContentTitleWidget(
            title: "تعديل المنشور",
            textColor: widget.withWithCard
                ? AppColor.primaryDarkColor
                : AppColor.accentColor,
          ),

          //==> space
          SizedBox(height: Sizes.dimen_8.h),

          /// form
          Form(
            key: _formKey,
            child: Wrap(
              alignment: WrapAlignment.center,
              //spacing: 20, // to apply margin in the main axis of the wrap
              runSpacing: Sizes.dimen_4.h,
              children: [
                /// article title
                AppTextField(
                  controller: titleController,
                  label: "تعديل عنوان المنشور هنا",
                ),

                /// upload images
                UploadIdImageWidget(
                  text: "ارفق صور المنشور",
                  onPressed: () => _pickImageCubit.pickMultiImage(),
                ),

                TextFieldLargeContainer(
                  appTextField: AppTextField(
                    controller: descriptionController,
                    label: "اكتب ما تفكر به هنا",
                    maxLines: 20,
                    validateOnSubmit: true,
                    withFocusedBorder: false,
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

  /// send article
  void _updateArticle() {
    // init userToken
    final userToken = widget.userToken;

    // init title
    final title = titleController.value.text;

    // init description
    final description = descriptionController.value.text;

    // send create sos request
    _updateArticleCubit.updateArticle(
      articleId: widget.articleEntity.id,
      title: title,
      description: description,
      imagePaths: _imagesPicked,
      token: userToken,
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(UpdateArticleState state) {
    if (state is LoadingUpdateArticle) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "تعديل المنشور",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isFormValid()) {
          _updateArticle();
        }
      },
    );
  }

  /// to validate the current form
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  /// to navigate to my articles screen
  void _navigateToMyArticlesScreen() {
    widget.onSuccess();
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
