import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/logic/client_cubit/end_task/end_task_client_cubit.dart';

class MyCompletedTasksClient extends StatefulWidget {
  final EndTaskClientCubit endTaskClientCubit;

  const MyCompletedTasksClient({
    Key? key,
    required this.endTaskClientCubit,
  }) : super(key: key);

  @override
  State<MyCompletedTasksClient> createState() => _MyCompletedTasksClientState();
}

class _MyCompletedTasksClientState extends State<MyCompletedTasksClient> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
