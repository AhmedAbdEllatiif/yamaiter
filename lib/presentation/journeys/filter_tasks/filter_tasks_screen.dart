import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/screen_arguments/filterd_tasks_args.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/drop_down_list.dart';
import '../../../common/constants/sizes.dart';
import '../../../common/screen_utils/screen_util.dart';
import '../../../domain/entities/data/task_entity.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/app_drop_down_field.dart';

class FilterTasksScreen extends StatefulWidget {
  const FilterTasksScreen({Key? key}) : super(key: key);

  @override
  State<FilterTasksScreen> createState() => _FilterTasksScreenState();
}

class _FilterTasksScreenState extends State<FilterTasksScreen> {
  /// chosen governorate
  String _chosenGovernorate = "";
  String? _errorGovernorate;

  /// chosen sortBy
  String _chosenSortBy = "";
  String? _errorSortBy;

  /// applicantsCount
  int applicantsCount = 4;

  /// FilterTasksCubit
  late final FilterTasksCubit _filterTasksCubit;

  FilterTasksParams? filterTasksParams;

  @override
  void initState() {
    super.initState();
    _filterTasksCubit = getItInstance<FilterTasksCubit>();
  }

  @override
  void dispose() {
    _filterTasksCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _filterTasksCubit,
      child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,

        /// appBar
        appBar: AppBar(),

        /// body
        body: BlocConsumer<FilterTasksCubit, FilterTasksState>(
          listener: (context, state) {
            print("State >> $state");
            if (state is FilteredTasksFetchedSuccessfully) {
              _navigateToFilteredTaskResultScreen(
                  taskList: state.taskEntityList);
            }

            if (state is LastPageFilterTasksFetched) {
              _navigateToFilteredTaskResultScreen(
                  taskList: state.taskEntityList);
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(
                top: ScreenUtil.screenHeight * 0.10,
                right: AppUtils.screenHorizontalPadding.w,
                left: AppUtils.screenHorizontalPadding.w,
              ),
              child: Column(
                children: [
                  /// title
                  Text(
                    "بحث المهام التفصيلى",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: Sizes.dimen_16.h,
                  ),

                  /// governoratesList
                  AppDropDownField(
                    hintText: "اختر المحافظة",
                    errorText: _errorGovernorate,
                    itemsList: governoratesList,
                    disabled: state is LoadingFilterTasksList,
                    onChanged: (value) {
                      if (value != null) {
                        _chosenGovernorate = value;
                        _hideOrShowError();
                      }
                    },
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  /// dropDown governoratesList
                  AppDropDownField(
                    hintText: "ترتيب المهام",
                    errorText: _errorSortBy,
                    itemsList: sortTasksBy.values.toList(),
                    disabled: state is LoadingFilterTasksList,
                    onChanged: (value) {
                      if (value != null) {
                        _chosenSortBy = value;
                        _hideOrShowError();
                      }
                    },
                  ),

                  SizedBox(
                    height: Sizes.dimen_8.h,
                  ),

                  // applicants count text
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "عدد المتقدمين",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  /// radio
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: AppColor.accentColor,
                              value: 4,
                              groupValue: applicantsCount,
                              onChanged: state is LoadingFilterTasksList
                                  ? null
                                  : (value) {
                                      setState(() {
                                        applicantsCount = 4;
                                      });
                                    },
                            ),
                            Text(
                              "اقل من 5",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: AppColor.accentColor,
                              value: 6,
                              groupValue: applicantsCount,
                              onChanged: state is LoadingFilterTasksList
                                  ? null
                                  : (value) {
                                      setState(() {
                                        applicantsCount = 6;
                                      });
                                    },
                            ),
                            Text(
                              "5-10",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 11,
                              groupValue: applicantsCount,
                              activeColor: AppColor.accentColor,
                              onChanged: state is LoadingFilterTasksList
                                  ? null
                                  : (value) {
                                      setState(() {
                                        applicantsCount = 11;
                                      });
                                    },
                            ),
                            Text(
                              "اكثر من 10",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AppColor.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  /// button or Loading
                  state is LoadingFilterTasksList
                      ? const LoadingWidget()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: Sizes.dimen_16.h,
                            ),
                            AppButton(
                              text: "اظهر النتائج",
                              width: double.infinity,
                              color: AppColor.accentColor,
                              textColor: AppColor.primaryDarkColor,
                              onPressed: () {
                                if (_validate()) {
                                  _fetchTasks();
                                }
                              },
                            )
                          ],
                        ),

                  /// Empty list
                  if (state is EmptyFilterTasks)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: Sizes.dimen_16.h,
                        ),
                        Text(
                          "* لا يوجد مهام بهذه المواصفات *",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _fetchTasks() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // init orderedBy
    final orderedBy = sortTasksBy.keys.firstWhere(
      //==> return the key if the value == _chosenSortBy
      (element) => sortTasksBy[element] == _chosenSortBy,
      //==> else return "newest"
      orElse: () => "newest",
    );

    // init params
    filterTasksParams = FilterTasksParams(
      userToken: userToken,
      city: _chosenGovernorate,
      orderedBy: orderedBy,
      applicantsCount: applicantsCount,
      offset: 0,
    );

    _filterTasksCubit.filterTasksList(
      filterTasksParams: filterTasksParams!,
      currentListLength: 0,
    );
  }

  void _navigateToFilteredTaskResultScreen(
      {required List<TaskEntity> taskList}) {
    if (filterTasksParams != null) {
      RouteHelper().filteredTasksResult(
        context,
        filteredTasksArguments: FilteredTasksArguments(
            filterTasksParams: filterTasksParams!, fetchedTasks: taskList),
      );
    } else {
      log("FilterTasksScreen >> _navigateToFilteredTaskResultScreen >> null params");
    }
  }

  /// to validate on chosen values
  bool _validate() {
    if (_chosenGovernorate.isEmpty) {
      _hideOrShowError();
      return false;
    }

    if (_chosenSortBy.isEmpty) {
      _hideOrShowError();
      return false;
    }

    return true;
  }

  /// to show or hide error texts
  void _hideOrShowError() {
    setState(() {
      _errorGovernorate = _chosenGovernorate.isEmpty ? "اختر المحافظة" : null;
      _errorSortBy = _chosenSortBy.isEmpty ? "اختر ترتيب المهام" : null;
    });
  }
}
