import 'package:yamaiter/presentation/logic/cubit/upload_task_file/upload_task_file_cubit.dart';

class UploadTaskFileArguments {
  final UploadTaskFileCubit? uploadTaskFileCubit;
  final int taskId;

  UploadTaskFileArguments({
    this.uploadTaskFileCubit,
    required this.taskId,
  });
}
