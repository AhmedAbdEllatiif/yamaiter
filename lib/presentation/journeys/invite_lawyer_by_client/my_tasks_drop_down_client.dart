import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';

class MyTasksDropDownClient extends StatelessWidget {
  final GetMyTasksCubit getMyTasksCubit;
  final Function(dynamic?) onChanged;
  final String? errorText;

  const MyTasksDropDownClient({
    Key? key,
    required this.getMyTasksCubit,
    required this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyTasksCubit, GetMyTasksState>(
      bloc: getMyTasksCubit,
      builder: (context, state) {
        /// loading
        if (state is LoadingGetMyTasksList) {
          return const LoadingWidget();
        }

        /// names fetched
        if (state is MyTasksListFetchedSuccessfully) {
          if (state.taskEntityList.isNotEmpty) {
            return AppDropDownField(
              hintText: "اختر مهمة من مهامك المضافة سابقا",
              errorText: errorText,
              taskItems: state.taskEntityList,
              onChanged: onChanged,
            );
          }
        }

        /// else
        return const SizedBox.shrink();
      },
    );
  }
}
