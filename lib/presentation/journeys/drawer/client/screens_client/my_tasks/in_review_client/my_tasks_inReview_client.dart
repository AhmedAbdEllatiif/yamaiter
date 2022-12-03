import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/logic/client_cubit/end_task/end_task_client_cubit.dart';

class MyTasksInReviewClient extends StatefulWidget {
  final EndTaskClientCubit endTaskClientCubit;

  const MyTasksInReviewClient({
    Key? key,
    required this.endTaskClientCubit,
  }) : super(key: key);

  @override
  State<MyTasksInReviewClient> createState() => _MyTasksInReviewClientState();
}

class _MyTasksInReviewClientState extends State<MyTasksInReviewClient> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
