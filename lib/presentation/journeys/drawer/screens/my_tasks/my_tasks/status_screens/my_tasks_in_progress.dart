import 'package:flutter/material.dart';

class MyTasksInProgress extends StatefulWidget {
  const MyTasksInProgress({Key? key}) : super(key: key);

  @override
  State<MyTasksInProgress> createState() => _MyTasksInProgressState();
}

class _MyTasksInProgressState extends State<MyTasksInProgress> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("InProgress"),
    );
  }
}
