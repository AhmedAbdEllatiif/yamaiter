import 'package:flutter/material.dart';

class MyTasksInReview extends StatefulWidget {
  const MyTasksInReview({Key? key}) : super(key: key);

  @override
  State<MyTasksInReview> createState() => _MyTasksInReviewState();
}

class _MyTasksInReviewState extends State<MyTasksInReview> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("InReview"),
    );
  }
}
