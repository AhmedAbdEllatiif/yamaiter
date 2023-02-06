import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';
import 'package:yamaiter/domain/entities/data/authorized_user_entity.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/forms/client_edit_profile_form.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/edit_profile/forms/lawyer_edit_profile_form.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/functions/get_user_token.dart';
import '../../../../../di/git_it_instance.dart';
import '../../../../logic/cubit/pick_images/pick_image_cubit.dart';
import '../../../../logic/cubit/update_client_profile/update_client_profile_cubit.dart';
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

  /// AuthorizedUserEntity
  late final AuthorizedUserEntity _authorizedUserEntity;

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
  }

  @override
  void dispose() {
    _pickImageCubit.close();
    _updateClientCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _pickImageCubit),
        BlocProvider(create: (context) => _updateClientCubit),
      ],
      child: BlocListener<UpdateClientProfileCubit, UpdateClientProfileState>(
        listener: (context, state) {
          if (state is ErrorWhileUpdatingClientProfile) {
            showSnackBar(context, message: "حدث خطأ، اعد المحاولة",
            backgroundColor: AppColor.accentColor);
          }
        },
        child: BlocListener<PickImageCubit, PickImageState>(
          listener: (context, state) {
            if (state is ImagePicked) {
              _profileImagePath = state.image.path;
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,

            /// appBar
            appBar: AppBar(
              title: const Text("الملف الشخصى"),
            ),

            /// body
            body:
                BlocBuilder<UpdateClientProfileCubit, UpdateClientProfileState>(
              builder: (context, state) {
                return Column(
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
                                authorizedUserEntity: _authorizedUserEntity,
                              )
                            : ClientEditProfileForm(
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
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _initAuthorizedUserEntity() {
    _authorizedUserEntity = getAuthorizedUserEntity(context);
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
