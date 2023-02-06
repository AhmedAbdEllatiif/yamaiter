import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../../../../common/constants/drop_down_list.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_drop_down_field.dart';
import '../../../../../widgets/app_text_field.dart';

class LawyerEditProfileForm extends StatefulWidget {
  final AuthorizedUserEntity authorizedUserEntity;
  const LawyerEditProfileForm({
    Key? key, required this.authorizedUserEntity,
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
  final TextEditingController aboutYourSelf = TextEditingController();

  /// dropDown results
  String _governorate = " ";
  String _subGovernorate = " ";

  late final AuthorizedUserEntity _authorizedUserEntity;


  @override
  void initState() {
    super.initState();
    _authorizedUserEntity = widget.authorizedUserEntity;

    firstNameController.text = _authorizedUserEntity.firstName;
    lastNameController.text = _authorizedUserEntity.lastName;
    mobileController.text = _authorizedUserEntity.phoneNum;
    emailController.text = _authorizedUserEntity.email;
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
                      margin: EdgeInsets.only(
                        top: Sizes.dimen_2.h,
                        bottom: Sizes.dimen_4.h,
                      ),
                    ),

                    // name
                    AppTextField(
                      //height: Sizes.dimen_18.h,
                      label: "الاسم الاخير",
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
                      textInputType:
                      TextInputType.number,
                      margin: EdgeInsets.only(
                          bottom: Sizes.dimen_4.h),
                    ),

                    // email
                    AppTextField(
                      //height: Sizes.dimen_18.h,
                      label: "البريد الالكترونى",
                      controller: emailController,
                      textInputType:
                      TextInputType.emailAddress,
                      margin: EdgeInsets.only(
                          bottom: Sizes.dimen_4.h),
                    ),

                    // governoratesList
                    AppDropDownField(
                      hintText: "المحافظة محل العمل",
                      initialValue: _governorate,
                      itemsList: governoratesList,
                      //height: Sizes.dimen_22.h,
                      margin: EdgeInsets.only(
                          bottom: Sizes.dimen_4.h),
                      onChanged: (value) {
                        if (value != null) {
                          _governorate = value;
                        }
                      },
                    ),

                    // dropdown
                    AppDropDownField(
                      hintText:
                      "دائرة المحكمة الكلية العليا",
                      initialValue: _subGovernorate,
                      itemsList: subGovernoratesList,
                      // height: Sizes.dimen_22.h,
                      margin: EdgeInsets.only(
                          bottom: Sizes.dimen_4.h),
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
                      minLines: 1,
                      maxLines: 10,
                      controller: aboutYourSelf,
                      textInputType:
                      TextInputType.multiline,
                      textInputAction:
                      TextInputAction.newline,
                      margin: EdgeInsets.only(
                          bottom: Sizes.dimen_4.h),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: "اضافة التعديلات",
                        color: AppColor.accentColor,
                        textColor:
                        AppColor.primaryDarkColor,
                        withAnimation: true,
                        onPressed: () {
                          if (_isFormValid()) {}
                        },
                      ),
                    ),
                    //==> bottom space
                    SizedBox(
                        height: Sizes.dimen_10.h),
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
}
