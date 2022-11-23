import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/presentation/logic/cubit/get_my_tasks/get_my_tasks_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_drop_down_field.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

class MyTasksDropDown extends StatelessWidget {
  final GetMyTasksCubit getMyTasksCubit;
  final Function(String?) onChanged;
  final String? errorText;

  const MyTasksDropDown({
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
        if (state is OnlyNames) {
          if (state.names.isNotEmpty) {
            return AppDropDownField(
              hintText: "اختر مهمة من مهامك المضافة سابقا",
              errorText: errorText,
              itemsList: state.names,
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
