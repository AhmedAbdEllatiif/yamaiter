import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/logic/cubit/filter_tasks/filter_task_cubit.dart';

class FilteredTasksArguments {
  final FilterTasksCubit filterTasksCubit;
  final FilterTasksParams filterTasksParams;
  final List<TaskEntity> fetchedTasks;

  FilteredTasksArguments( {
    required this.filterTasksCubit,
    required this.filterTasksParams,
    required this.fetchedTasks,
  });
}
