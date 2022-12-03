import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/data/task_entity.dart';
import 'package:yamaiter/presentation/journeys/drawer/client/screens_client/my_tasks/todo_client/todo_task_item_client.dart';
import 'package:yamaiter/presentation/logic/client_cubit/assign_task/assign_task_client_cubit.dart';

class MyTasksTodoClient extends StatefulWidget {
  final AssignTaskClientCubit assignTaskClientCubit;

  const MyTasksTodoClient({Key? key, required this.assignTaskClientCubit})
      : super(key: key);

  @override
  State<MyTasksTodoClient> createState() => _MyTasksTodoClientState();
}

class _MyTasksTodoClientState extends State<MyTasksTodoClient> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TodoTaskItemClient(
            taskEntity: TaskEntity.empty(),
            onUpdatePressed: () {print("Updated");},
            onDeletePressed: () {print("deleted");},
            onPressed: () {})
      ],
    );
  }
}
