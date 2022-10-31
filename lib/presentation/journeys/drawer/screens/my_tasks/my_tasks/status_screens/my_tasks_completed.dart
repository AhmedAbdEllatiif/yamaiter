import 'package:flutter/material.dart';

class MyTasksCompleted extends StatefulWidget {
  const MyTasksCompleted({Key? key}) : super(key: key);

  @override
  State<MyTasksCompleted> createState() => _MyTasksCompletedState();
}

class _MyTasksCompletedState extends State<MyTasksCompleted> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed"),
    );
  }
}
