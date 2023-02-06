import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/update_client_profile/update_client_profile_cubit.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../../../../../common/constants/drop_down_list.dart';
import '../../../../../../common/constants/sizes.dart';
import '../../../../../themes/theme_color.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_drop_down_field.dart';
import '../../../../../widgets/app_text_field.dart';

class ClientEditProfileForm extends StatefulWidget {
  final UpdateClientProfileCubit updateClientProfileCubit;
  
  final Function({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String governorate,
  }) onSubmit;

  const ClientEditProfileForm({
    Key? key,
    required this.updateClientProfileCubit,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ClientEditProfileForm> createState() => _ClientEditProfileFormState();
}

class _ClientEditProfileFormState extends State<ClientEditProfileForm> {
  /// form key
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  String _governorate = " ";

  late final AuthorizedUserEntity _authorizedUserEntity;

  @override
  void initState() {
    super.initState();
    _authorizedUserEntity = getAuthorizedUserEntity(context);

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

                /// button
                BlocBuilder<UpdateClientProfileCubit, UpdateClientProfileState>(
                  bloc: widget.updateClientProfileCubit,
                  builder: (context, state) {
                    if (state is LoadingUpdateClientProfile) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: "اضافة التعديلات",
                        color: AppColor.accentColor,
                        textColor: AppColor.primaryDarkColor,
                        withAnimation: true,
                        onPressed: () {
                          if (_isFormValid()) {
                            _submitClientForm();
                          }
                        },
                      ),
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
        SizedBox(height: Sizes.dimen_160.h),
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

  void _submitClientForm() {
    final firstName = firstNameController.value.text;
    final lastName = lastNameController.value.text;
    final mobile = mobileController.value.text;
    final email = emailController.value.text;

    widget.onSubmit(
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      email: email,
      governorate: _governorate,
    );
  }
}
