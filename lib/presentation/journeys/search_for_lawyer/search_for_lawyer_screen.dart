import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/drop_down_list.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/enum/app_error_type.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../domain/entities/data/lawyer_entity.dart';
import '../../../domain/entities/screen_arguments/search_result_args.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_drop_down_field.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class SearchForLawyerScreen extends StatefulWidget {
  const SearchForLawyerScreen({Key? key}) : super(key: key);

  @override
  State<SearchForLawyerScreen> createState() => _SearchForLawyerScreenState();
}

class _SearchForLawyerScreenState extends State<SearchForLawyerScreen> {
  /// SearchForLawyersCubit
  late final SearchForLawyersCubit _searchForLawyersCubit;

  /// current value
  String chosenValue = "";

  /// errorText
  String? errorText;

  @override
  void initState() {
    super.initState();
    _searchForLawyersCubit = getItInstance<SearchForLawyersCubit>();
  }

  @override
  void dispose() {
    _searchForLawyersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchForLawyersCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: BlocConsumer<SearchForLawyersCubit, SearchForLawyersState>(
          //==> listener
          listener: (context, state) {
            // success result
            if (state is SearchLawyersResult) {
              _navigateToSearchResult(resultList: state.lawyersResult);
            }

            // last page reached
            if (state is LastPageSearchForLawyersFetched) {
              _navigateToSearchResult(resultList: state.lawyersResult);
            }
          },

          //==> builder
          builder: (context, state) {
            /// UnAuthorized
            if (state is UnAuthorizedSearchForLawyers) {
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
            if (state is NotActivatedUserToSearchForLawyers) {
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

            /// else
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColor.primaryDarkColor,
              child: Container(
                padding: EdgeInsets.only(
                  top: ScreenUtil.screenHeight * .10,
                  right: AppUtils.screenHorizontalPadding.w,
                  left: AppUtils.screenHorizontalPadding.w,
                ),
                child: Column(
                  children: [
                    /// title
                    Text(
                      "يامتر ابحث عن محامى فى محافظة.. ؟",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    SizedBox(
                      height: Sizes.dimen_16.h,
                    ),

                    /// dropDown
                    AppDropDownField(
                      hintText: "اختر محافظة البحث",
                      errorText: errorText,
                      itemsList: governoratesList,
                      onChanged: (value) {
                        if (value != null) {
                          chosenValue = value;
                          _showOrHideError(false);
                        }
                      },
                    ),
                    SizedBox(
                      height: Sizes.dimen_16.h,
                    ),

                    /// search button
                    state is LoadingSearchForLawyersList
                        ? const LoadingWidget()
                        : AppButton(
                            text: "ابحث الان",
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: Sizes.dimen_30.w),
                            color: AppColor.accentColor,
                            textColor: AppColor.white,
                            fontSize: Sizes.dimen_16.sp,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (_validate()) {
                                _searchForLawyers();
                              }
                            },
                          ),

                    /// NoLawyersFound
                    if (state is NoLawyersFound)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: Sizes.dimen_16.h,
                          ),
                          Text(
                            "* لا يوجد محامين فى هذه المحافظة *",
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// To search for lawyers
  void _searchForLawyers() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _searchForLawyersCubit.searchForLawyer(
        userToken: userToken, governorates: chosenValue, currentListLength: 0);
  }

  /// to validate on chosen governorates
  bool _validate() {
    if (chosenValue.isNotEmpty) return true;
    _showOrHideError(true);
    return false;
  }

  /// to hide to show error text
  void _showOrHideError(bool isShow) {
    setState(() {
      errorText = isShow ? "اختر محافظة البحث" : null;
    });
  }

  /// To navigate to search result screen
  void _navigateToSearchResult({required List<LawyerEntity> resultList}) {
    RouteHelper().searchResult(
      context,
      searchResultArguments: SearchResultArguments(
        lawyersResult: resultList,
        searchForLawyersCubit: _searchForLawyersCubit,
        governorates: chosenValue,
      ),
    );
  }

  /// navigate to login
  void _navigateToLogin() =>
      RouteHelper().loginScreen(context, isClearStack: true);

  /// navigate to contact us
  void _navigateToContactUs() => RouteHelper().contactUsScreen(context);
}
