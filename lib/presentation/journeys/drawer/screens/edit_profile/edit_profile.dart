import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/app_text_field.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';
import 'package:yamaiter/presentation/widgets/static_pages_title_widget.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../di/git_it.dart';
import '../../../../logic/cubit/pick_images/pick_image_cubit.dart';
import 'choose_profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// pick image cubit
  late final PickImageCubit _pickImageCubit;

  /// form key
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController aboutYourSelf = TextEditingController();

  /// dropDown results
  String _governorate = " ";
  String _subGovernorate = " ";

  /// profile image path
  String _profileImagePath = " ";

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _pickImageCubit,
      child: BlocListener<PickImageCubit, PickImageState>(
        listener: (context, state) {
          if (state is ImagePicked) {
            _profileImagePath = state.image.path;
          }
        },
        child: Scaffold(
          /// appBar
          appBar: AppBar(title: const Text("الملف الشخصى"),),

          /// body
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //==> title
                const StaticPageTitleWidget(title: "تعديل الملف الشخصى"),

                //==> person icon and text
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //==> profile image
                        const Center(child: ChooseProfileImageWidget()),

                        //==> Card with text
                        Container(
                          margin: EdgeInsets.only(top: Sizes.dimen_5.h),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.dimen_20.w,
                                vertical: Sizes.dimen_10.h,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // name
                                    AppTextField(
                                      //height: Sizes.dimen_18.h,
                                      label: "الاسم",
                                      margin: EdgeInsets.only(
                                        top: Sizes.dimen_2.h,
                                        bottom: Sizes.dimen_4.h,
                                      ),
                                    ),

                                    // phone num
                                    AppTextField(
                                      //height: Sizes.dimen_18.h,
                                      label: "الموبايل",
                                      textInputType: TextInputType.number,
                                      margin: EdgeInsets.only(
                                          bottom: Sizes.dimen_4.h),
                                    ),

                                    // email
                                    AppTextField(
                                      //height: Sizes.dimen_18.h,
                                      label: "البريد الالكترونى",
                                      textInputType: TextInputType.emailAddress,
                                      margin: EdgeInsets.only(
                                          bottom: Sizes.dimen_4.h),
                                    ),

                                    // governoratesList
                                    AppDropDownField(
                                      hintText: "المحافظة محل العمل",
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
                                      hintText: "دائرة المحكمة الكلية العليا",
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
                                      textInputType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      margin: EdgeInsets.only(
                                          bottom: Sizes.dimen_4.h),
                                    ),

                                    SizedBox(
                                      width: double.infinity,
                                      child: AppButton(
                                        text: "اضافة التعديلات",
                                        color: AppColor.accentColor,
                                        textColor: AppColor.primaryDarkColor,
                                        withAnimation: true,
                                        onPressed: () {
                                          if (_isFormValid()) {}
                                        },
                                      ),
                                    ),
                                    //==> bottom space
                                    SizedBox(height: Sizes.dimen_10.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        //==> bottom space
                        SizedBox(height: Sizes.dimen_30.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // return true if the form is valid
  bool _isFormValid() {
    if (_formKey.currentState != null) {
      return _formKey.currentState!.validate();
    }
    return false;
  }
}
