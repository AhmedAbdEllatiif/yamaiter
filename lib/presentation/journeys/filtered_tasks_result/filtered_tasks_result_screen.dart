import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/filterd_tasks_args.dart';
import 'package:yamaiter/presentation/widgets/task_item.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';

import '../../../domain/entities/data/task_entity.dart';
import 'loading_more_tasks_with_filter.dart';

class FilteredTasksResultScreen extends StatefulWidget {
  final FilteredTasksArguments filteredTaskArguments;

  const FilteredTasksResultScreen({
    Key? key,
    required this.filteredTaskArguments,
  }) : super(key: key);

  @override
  State<FilteredTasksResultScreen> createState() =>
      _FilteredTasksResultScreenState();
}

class _FilteredTasksResultScreenState extends State<FilteredTasksResultScreen> {
  /// FilterTasksCubit
  late final FilterTasksCubit _filterTasksCubit;

  /// Filter tasks params to fetch task with
  late final FilterTasksParams _filterTasksParams;

  /// list of TaskEntity
  late final List<TaskEntity> tasksList;

  /// ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    //==> init _filterTasksCubit
    _filterTasksCubit = getItInstance<FilterTasksCubit>();
    ;

    //==> init filter params
    _filterTasksParams = widget.filteredTaskArguments.filterTasksParams;

    //==> init the list of TaskEntity
    tasksList = widget.filteredTaskArguments.fetchedTasks;

    //==> init _controller
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _filterTasksCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _filterTasksCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("نتائج البحث"),
        ),

        /// body
        body: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: AppUtils.mainPagesHorizontalPadding.w,
            left: AppUtils.mainPagesHorizontalPadding.w,
            //bottom: AppUtils.mainPagesVerticalPadding.h,
          ),
          child: BlocConsumer<FilterTasksCubit, FilterTasksState>(
            bloc: _filterTasksCubit,
            listener: (context, state) {
              /// lastPage
              if (state is LastPageFilterTasksFetched) {
                tasksList.addAll(state.taskEntityList);
              }

              /// fetched
              if (state is FilteredTasksFetchedSuccessfully) {
                tasksList.addAll(state.taskEntityList);
                log("Size: ${tasksList.length}");
              }
            },
            builder: (context, state) {
              return ListView.separated(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,

                //==> itemCount
                itemCount: tasksList.length + 1,

                //==> separatorBuilder
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Sizes.dimen_10.h,
                  );
                },

                //==> itemBuilder
                itemBuilder: (context, index) {
                  if (index < tasksList.length) {
                    return TaskItem(taskEntity: tasksList[index]);
                  }

                  /// loading or end of list
                  return LoadingTasksWithFilterWidget(
                    filterTasksCubit: _filterTasksCubit,
                  );
                  return TaskItem(taskEntity: tasksList[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_filterTasksCubit.state is! LastPageFilterTasksFetched) {
          _fetchTasks();
        }
      }
    });
  }

  /// to fetch tasks with the same params
  void _fetchTasks() {
    //==> update offset
    final params = FilterTasksParams(
        userToken: _filterTasksParams.userToken,
        city: _filterTasksParams.city,
        orderedBy: _filterTasksParams.orderedBy,
        applicantsCount: _filterTasksParams.applicantsCount,
        offset: tasksList.length);

    _filterTasksCubit.filterTasksList(
      filterTasksParams: params,
      currentListLength: tasksList.length,
    );
  }
}
