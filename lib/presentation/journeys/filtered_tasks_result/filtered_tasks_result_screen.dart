import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/domain/entities/screen_arguments/filterd_tasks_args.dart';
import 'package:yamaiter/presentation/journeys/bottom_nav_screens/all_tasks/all_tasks_item.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';

import '../../../domain/entities/data/task_entity.dart';

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
  late final FilterTasksCubit _filterTasksCubit;
  late final FilterTasksParams _filterTasksParams;
  late final List<TaskEntity> tasksList;

  @override
  void initState() {
    super.initState();
    _filterTasksCubit = widget.filteredTaskArguments.filterTasksCubit;
    _filterTasksParams = widget.filteredTaskArguments.filterTasksParams;
    tasksList = widget.filteredTaskArguments.fetchedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("نتائج البحث"),
      ),

      /// body
      body: BlocConsumer<FilterTasksCubit, FilterTasksState>(
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
            //==> itemCount
            itemCount: tasksList.length,

            //==> separatorBuilder
            separatorBuilder: (context, index) {
              return SizedBox(
                height: Sizes.dimen_10.h,
              );
            },

            //==> itemBuilder
            itemBuilder: (context, index) {
              return AllTasksItem(taskEntity: tasksList[index]);
            },
          );
        },
      ),
    );
  }
}
