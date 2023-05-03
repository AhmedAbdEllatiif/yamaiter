import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../../../../common/constants/drop_down_list.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/functions/get_authoried_user.dart';
import '../../../../../logic/cubit/update_lawyer_profile/update_lawyer_profile_cubit.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_drop_down_field.dart';
import '../../../../../widgets/app_text_field.dart';
import '../../../../../widgets/loading_widget.dart';

class LawyerEditProfileForm extends StatefulWidget {
  final UpdateLawyerProfileCubit updateLawyerProfileCubit;

  final Function({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String governorate,
    required String court,
    required String description,
  }) onSubmit;

  const LawyerEditProfileForm({
    Key? key,
    required this.updateLawyerProfileCubit,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<LawyerEditProfileForm> createState() => _LawyerEditProfileFormState();
}

class _LawyerEditProfileFormState extends State<LawyerEditProfileForm> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// dropDown results
  String _governorate = "";
  String _subGovernorate = "";

  late final AuthorizedUserEntity _authorizedUserEntity;

  @override
  void initState() {
    super.initState();
    _authorizedUserEntity = getAuthorizedUserEntity(context);

    firstNameController.text = _authorizedUserEntity.firstName;
    lastNameController.text = _authorizedUserEntity.lastName;
    mobileController.text = _authorizedUserEntity.phoneNum;
    emailController.text = _authorizedUserEntity.email;
    _governorate = _authorizedUserEntity.governorates;
    _subGovernorate = _authorizedUserEntity.courtName;
    // descriptionController.text = _authorizedUserEntity.;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableAppCard(
        child: Column(
      children: [
        //==> Card with text
        Container(
          margin: EdgeInsets.only(top: Sizes.dimen_5.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // name
                AppTextField(
                  //height: Sizes.dimen_18.h,
                  label: "الاسم الاول",
                  controller: firstNameController,
                  validateOnSubmit: false,
                  margin: EdgeInsets.only(
                    top: Sizes.dimen_2.h,
                    bottom: Sizes.dimen_4.h,
                  ),
                ),

                // name
                AppTextField(
                  //height: Sizes.dimen_18.h,
                  label: "الاسم الاخير",
                  validateOnSubmit: false,
                  controller: lastNameController,
                  margin: EdgeInsets.only(
                    top: Sizes.dimen_2.h,
                    bottom: Sizes.dimen_4.h,
                  ),
                ),

                // phone num
                AppTextField(
                  //height: Sizes.dimen_18.h,
                  label: "الموبايل",
                  controller: mobileController,
                  textInputType: TextInputType.number,
                  validateOnSubmit: false,
                  margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
                ),

                // email
                AppTextField(
                  //height: Sizes.dimen_18.h,
                  label: "البريد الالكترونى",
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validateOnSubmit: false,
                  margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
                ),

                // governoratesList
                AppDropDownField(
                  hintText: "المحافظة محل العمل",
                  initialValue: _governorate,
                  itemsList: governoratesList,
                  //height: Sizes.dimen_22.h,
                  validateOnSubmit: false,
                  margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
                  onChanged: (value) {
                    if (value != null) {
                      _governorate = value;
                    }
                  },
                ),

                // dropdown
                AppDropDownField(
                  hintText: "دائرة المحكمة الكلية العليا",
                  initialValue: _subGovernorate,
                  itemsList: subGovernoratesList,
                  // height: Sizes.dimen_22.h,
                  validateOnSubmit: false,
                  margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
                  onChanged: (value) {
                    if (value != null) {
                      _subGovernorate = value;
                    }
                  },
                ),

                // about your self
                AppTextField(
                  // height: Sizes.dimen_100.h,
                  label: "اكتب عن نفسك هنا",
                  validateOnSubmit: false,
                  minLines: 1,
                  maxLines: 10,
                  controller: descriptionController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  margin: EdgeInsets.only(bottom: Sizes.dimen_4.h),
                ),

                BlocBuilder<UpdateLawyerProfileCubit, UpdateLawyerProfileState>(
                  builder: (context, state) {
                    if (state is LoadingUpdateLawyerProfile) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    return AppButton(
                      text: "اضافة التعديلات",
                      color: AppColor.accentColor,
                      textColor: AppColor.primaryDarkColor,
                      withAnimation: true,
                      width: double.infinity,
                      onPressed: () {
                        if (_isFormValid()) {
                          _submitLawyerForm();
                        }
                      },
                    );
                  },
                ),
                //==> bottom space
                SizedBox(height: Sizes.dimen_10.h),
              ],
            ),
          ),
        ),

        //==> bottom space
        SizedBox(height: Sizes.dimen_200.h),
      ],
    ));
  }

  // return true if the form is valid
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }

  void _submitLawyerForm() {
    final firstName = firstNameController.value.text;
    final lastName = lastNameController.value.text;
    final mobile = mobileController.value.text;
    final email = emailController.value.text;
    final description = descriptionController.value.text;

    widget.onSubmit(
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      email: email,
      governorate: _governorate,
      court: _subGovernorate,
      description: description,
    );
  }
}
