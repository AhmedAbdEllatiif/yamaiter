import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/forms/client_edit_profile_form.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/forms/lawyer_edit_profile_form.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/functions/get_user_token.dart';
import '../../../../../di/git_it_instance.dart';
import '../../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../../logic/cubit/update_client_profile/update_client_profile_cubit.dart';
import '../../../../logic/cubit/update_lawyer_profile/update_lawyer_profile_cubit.dart';
import 'choose_profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// pick image cubit
  late final PickImageCubit _pickImageCubit;

  /// UpdateClientProfileCubit
  late final UpdateClientProfileCubit _updateClientCubit;

  /// UpdateLawyerProfileCubit
  late final UpdateLawyerProfileCubit _updateLawyerCubit;

  /// profile image path
  String _profileImagePath = " ";

  @override
  void initState() {
    super.initState();
    _pickImageCubit = getItInstance<PickImageCubit>();

    // init _authorizedUserEntity
    _initAuthorizedUserEntity();

    // init _updateClientCubit
    _updateClientCubit = getItInstance<UpdateClientProfileCubit>();

    // init _updateLawyerCubit
    _updateLawyerCubit = getItInstance<UpdateLawyerProfileCubit>();
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    _updateClientCubit.close();
    _updateLawyerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
        BlocProvider(create: (context) => _updateClientCubit),
        BlocProvider(create: (context) => _updateLawyerCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /// UpdateClientProfileCubit listener
          BlocListener<UpdateClientProfileCubit, UpdateClientProfileState>(
              listener: (context, state) {
            if (state is ErrorWhileUpdatingClientProfile) {
              showSnackBar(context,
                  message: "حدث خطأ، اعد المحاولة",
                  backgroundColor: AppColor.accentColor);
            }
            if (state is ClientProfileUpdatedSuccessfully) {
              reloadAuthorizedUserEntity(context);
            }
          }),

          /// UpdateLawyerProfileCubit listener
          BlocListener<UpdateLawyerProfileCubit, UpdateLawyerProfileState>(
              listener: (context, state) {
            if (state is ErrorWhileUpdatingLawyerProfile) {
              showSnackBar(context,
                  message: "حدث خطأ، اعد المحاولة",
                  backgroundColor: AppColor.accentColor);
            }

            if (state is LawyerProfileUpdatedSuccessfully) {
              reloadAuthorizedUserEntity(context);
            }
          }),

          /// PickImageCubit listener
          BlocListener<PickImageCubit, PickImageState>(
              listener: (context, state) {
            if (state is ImagePicked) {
              _profileImagePath = state.image.path;
            }
          }),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,

          /// appBar
          appBar: AppBar(
            title: const Text("الملف الشخصى"),
          ),

          /// body
          body: Column(
            children: [
              /// image
              const ChooseProfileImageWidget(),

              /// form
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_20.w,
                    vertical: Sizes.dimen_10.h,
                  ),
                  child: isCurrentUserLawyer(context)
                      ? LawyerEditProfileForm(
                          updateLawyerProfileCubit: _updateLawyerCubit,
                          onSubmit: ({
                            required String firstName,
                            required String lastName,
                            required String mobile,
                            required String email,
                            required String governorate,
                            required String court,
                            required String description,
                          }) {
                            _updateLawyerProfileOnSubmit(
                              firstName: firstName,
                              lastName: lastName,
                              mobile: mobile,
                              email: email,
                              governorate: governorate,
                              court: court,
                              description: description,
                            );
                          },
                        )
                      : BlocBuilder<UpdateClientProfileCubit,
                          UpdateClientProfileState>(
                          builder: (context, state) {
                            return ClientEditProfileForm(
                              updateClientProfileCubit: _updateClientCubit,
                              onSubmit: ({
                                required String firstName,
                                required String lastName,
                                required String mobile,
                                required String email,
                                required String governorate,
                              }) {
                                _updateClientProfileOnSubmit(
                                  firstName: firstName,
                                  lastName: lastName,
                                  mobile: mobile,
                                  email: email,
                                  governorate: governorate,
                                );
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initAuthorizedUserEntity() {
  }

  void _updateLawyerProfileOnSubmit({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String governorate,
    required String court,
    required String description,
  }) {
    final userToken = getUserToken(context);

    _updateLawyerCubit.tryUpdatingLawyerProfile(
      userToken: userToken,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobile: mobile,
      image: _profileImagePath,
      governorate: governorate,
      court: court,
      description: description,
    );
  }

  void _updateClientProfileOnSubmit({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String governorate,
  }) {
    final userToken = getUserToken(context);

    _updateClientCubit.tryUpdatingClientProfile(
        userToken: userToken,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        image: _profileImagePath,
        governorate: governorate);
  }
}
