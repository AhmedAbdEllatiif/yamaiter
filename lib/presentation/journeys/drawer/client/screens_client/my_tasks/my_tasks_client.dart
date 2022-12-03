import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/my_tasks_client_args.dart';

class MyTasksScreenClient extends StatefulWidget {
  final MyTasksClientArguments arguments;

  const MyTasksScreenClient({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<MyTasksScreenClient> createState() => _MyTasksScreenClientState();
}

class _MyTasksScreenClientState extends State<MyTasksScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("طلباتى المعروضة على المحامين"),
      ),
    );
  }
}
