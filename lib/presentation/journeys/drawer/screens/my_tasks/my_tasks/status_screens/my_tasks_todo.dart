import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_tasks/my_tasks/task_item.dart';

class MyTasksTodo extends StatefulWidget {
  const MyTasksTodo({Key? key}) : super(key: key);

  @override
  State<MyTasksTodo> createState() => _MyTasksTodoState();
}

class _MyTasksTodoState extends State<MyTasksTodo> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),

      // count
      itemCount: 10,

      // separatorBuilder
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: Sizes.dimen_10.h,
        );
      },

      // itemBuilder
      itemBuilder: (BuildContext context, int index) {
        return const TaskItem();
      },
    );
  }
}
