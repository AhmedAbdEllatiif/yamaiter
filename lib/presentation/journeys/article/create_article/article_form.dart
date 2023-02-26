import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/cubit/create_article/create_article_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/common_functions.dart';
import '../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_content_title_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scrollable_app_card.dart';
import '../../../widgets/text_field_large_container.dart';
import '../../reigster_lawyer/upload_id_image.dart';

class ArticleForm extends StatefulWidget {
  final bool withWithCard;
  final Function() onSuccess;
  final CreateArticleCubit? createArticleCubit;

  const ArticleForm({
    Key? key,
    this.withWithCard = true,
    required this.onSuccess,
    this.createArticleCubit,
  }) : super(key: key);

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// imagerPicker cubit
  late final PickImageCubit _pickImageCubit;

  /// CreateArticleCubit
  late final CreateArticleCubit _createArticleCubit;

  final List<String> _imagesPicked = [];

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
    _createArticleCubit =
        widget.createArticleCubit ?? getItInstance<CreateArticleCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();

    /// to close if the cubit init by the form state
    if(widget.createArticleCubit ==null){
      _createArticleCubit.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
        BlocProvider(create: (context) => _createArticleCubit),
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
          BlocListener<CreateArticleCubit, CreateArticleState>(
            bloc: _createArticleCubit,
            listener: (context, state) {
              //==> show snack bar with check internet connection
              if (state is ErrorWhileCreatingArticle) {
                showSnackBar(context,
                    backgroundColor: AppColor.accentColor,
                    textColor: AppColor.primaryDarkColor,
                    isFloating: false,
                    message: "تحقق من اتصال الإنترنت");
              }

              //==> on success navigate to my sos screen
              if (state is ArticleCreatedSuccessfully) {
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
            child: BlocBuilder<CreateArticleCubit, CreateArticleState>(
              bloc: _createArticleCubit,
                builder: (context, state) {
              /// UnAuthorizedCreateSos
              if (state is UnAuthorizedCreateArticle) {
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
              if (state is NotActivatedUserToCreateArticle) {
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
    );
  }

  Widget _form(CreateArticleState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: widget.withWithCard
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          /// title
          AppContentTitleWidget(
            title: "اضافة منشور",
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
                  label: "ضع عنوان المنشور هنا",
                  minLength: 5,
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
                    minLength: 5,
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
  void _sendArticle() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init title
    final title = titleController.value.text;

    // init description
    final description = descriptionController.value.text;

    // send create sos request
    _createArticleCubit.sendArticle(
      title: title,
      description: description,
      imagePaths: _imagesPicked,
      token: userToken,
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(CreateArticleState state) {
    if (state is LoadingCreateArticle) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "نشر",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isFormValid()) {
          _sendArticle();
        }
      },
    );
  }

  /// to validate the current form
  bool _isFormValid() {
    //==> validateOnMultiImages
    _pickImageCubit.validateOnMultiImages();

    if (_imagesPicked.isEmpty) {
      showSnackBar(context,
          isFloating: false,
          backgroundColor: AppColor.accentColor,
          textColor: AppColor.primaryDarkColor,
          message: "ارفاق صورة على الاقل مطلوب");
      return false;
    }

    //==> validate on form and received images list
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
