import 'package:yamaiter/data/params/filter_task_params.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';

class FilteredTasksArguments {
  final FilterTasksParams filterTasksParams;
  final List<TaskEntity> fetchedTasks;

  FilteredTasksArguments({
    required this.filterTasksParams,
    required this.fetchedTasks,
  });
}
