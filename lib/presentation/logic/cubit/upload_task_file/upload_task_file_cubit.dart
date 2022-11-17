import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/app_error.dart';

part 'upload_task_file_state.dart';

class UploadTaskFileCubit extends Cubit<UploadTaskFileState> {
  UploadTaskFileCubit() : super(UploadTaskFileInitial());
}
