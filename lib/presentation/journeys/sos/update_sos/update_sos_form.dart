import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/update_sos_cubit/update_sos_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/app_utils.dart';
import '../../../../common/constants/drop_down_list.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/common_functions.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_content_title_widget.dart';
import '../../../widgets/app_drop_down_field.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/scrollable_app_card.dart';
import '../../../widgets/text_field_large_container.dart';

class UpdateSosForm extends StatefulWidget {
  final bool withWithCard;
  final Function() onSuccess;
  final UpdateSosCubit? updateSosCubit;
  final String userToken;
  final SosEntity sosEntity;

  const UpdateSosForm({
    Key? key,
    this.withWithCard = true,
    required this.onSuccess,
    required this.updateSosCubit,
    required this.userToken,
    required this.sosEntity,
  }) : super(key: key);

  @override
  State<UpdateSosForm> createState() => _UpdateSosFormState();
}

class _UpdateSosFormState extends State<UpdateSosForm> {
  late final UpdateSosCubit _updateSosCubit;
  late final SosEntity _sosEntity;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  String type = "";
  String governorate = "";

  @override
  void initState() {
    super.initState();
    _updateSosCubit = widget.updateSosCubit ?? getItInstance<UpdateSosCubit>();
    _sosEntity = widget.sosEntity;
    descriptionController.text = _sosEntity.description;
  }

  @override
  void dispose() {
    if (widget.updateSosCubit == null) {
      _updateSosCubit.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateSosCubit,
      child: BlocListener<UpdateSosCubit, UpdateSosState>(
        bloc: _updateSosCubit,
        listener: (_, state) {
          //==> show snack bar with check internet connection
          if (state is ErrorWhileUpdatingSos) {
            showSnackBar(context, message: "تحقق من اتصال الإنترنت");
          }

          //==> on success navigate to my sos screen
          if (state is SosUpdatedSuccessfully) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
              vertical: AppUtils.mainPagesVerticalPadding.h,
            ),

            ///  card
            child: Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_10.h,
              ),
              child: BlocBuilder<UpdateSosCubit, UpdateSosState>(
                bloc: _updateSosCubit,
                builder: (context, state) {
                  /// UnAuthorizedCreateSos
                  if (state is UnAuthorizedUpdateSos) {
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
                  if (state is NotActivatedUserToUpdateSos) {
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
      ),
    );
  }

  Widget _form(UpdateSosState state) {
    return Column(
      crossAxisAlignment: widget.withWithCard
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        /// title
        AppContentTitleWidget(
          title: "تعديل الاستغاثة",
          textColor:
              widget.withWithCard ? AppColor.primaryDarkColor : AppColor.white,
        ),

        //==> space
        SizedBox(height: Sizes.dimen_8.h),

        Form(
          key: _formKey,
          child: Column(
            children: [
              AppDropDownField(
                  hintText: "تعديل حالة الطوارئ",
                  itemsList: sosTypeList,
                  initialValue:_sosEntity.title,
                  onChanged: (value) {
                    if (value != null) {
                      type = value;
                    }
                  }),

              //==> space
              SizedBox(height: Sizes.dimen_5.h),

              AppDropDownField(
                  hintText: "تعديل النطاق",
                  itemsList: governoratesListWithSelectAll,
                  isLastItemHighlighted: true,
                  initialValue:_sosEntity.governorate,
                  onChanged: (value) {
                    if (value != null) {
                      governorate = value;
                    }
                  }),

              //==> space
              SizedBox(height: Sizes.dimen_5.h),

              TextFieldLargeContainer(
                appTextField: AppTextField(
                  controller: descriptionController,
                  label: "اكتب تفاصيل ما تتعرض له للنشر على زملائك",
                  maxLines: 20,
                  validateOnSubmit: false,
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
    );
  }

  /// switch between loading or button
  Widget _switchLoadingAndButton(UpdateSosState state) {
    if (state is LoadingUpdateSos) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    return AppButton(
      text: "تعديل الاستغاثة",
      color: AppColor.accentColor,
      textColor: AppColor.primaryDarkColor,
      withAnimation: true,
      width: double.infinity,
      onPressed: () {
        if (_isAnyFieldChanged(context)) {
          _updateSos();
        }
      },
    );
  }

  /// return false if no field is updated
  bool _isAnyFieldChanged(BuildContext context) {
    if (type.isEmpty &&
        governorate.isEmpty &&
        descriptionController.value.text.isEmpty) {
      showSnackBar(context,
          message: "قم بتعديل محتوى على الاقل",
          isFloating: false,
          backgroundColor: AppColor.accentColor,
          textColor: AppColor.primaryDarkColor);
      return false;
    }

    return true;
  }

  /// send sos
  void _updateSos() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init description
    final description = descriptionController.value.text.isNotEmpty
        ? descriptionController.value.text
        : _sosEntity.description;

    // init type
    final typeToUpdate = type.isNotEmpty ? type : _sosEntity.title;

    // init governorate
    final governorateToUpdate =
        governorate.isNotEmpty ? governorate : _sosEntity.governorate;

    // send create sos request
    _updateSosCubit.updateSos(
      sosId: _sosEntity.id,
      type: typeToUpdate,
      governorate: governorateToUpdate,
      description: description,
      token: userToken,
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
