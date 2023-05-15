import 'package:flutter/cupertino.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/router/route_helper.dart';

enum ReceivedNotificationType {
  inprogressTask,
  consultation,
  tax,
  chat,
  task,
  completedTask,
  invitedTask,
  myTodoTask,
  inreviewTask,
  article,
  distress,
  unKnown,
}

ReceivedNotificationType receivedNotificationFromString(String? str) {
  if (str == null) {
    return ReceivedNotificationType.unKnown;
  }
  if (str == "inprogressTask") {
    return ReceivedNotificationType.inprogressTask;
  }
  if (str == "consultation") {
    return ReceivedNotificationType.consultation;
  }
  if (str == "tax") {
    return ReceivedNotificationType.tax;
  }
  if (str == "chat") {
    return ReceivedNotificationType.chat;
  }
  if (str == "task") {
    return ReceivedNotificationType.task;
  }
  if (str == "completedTask") {
    return ReceivedNotificationType.completedTask;
  }
  if (str == "invitedTask") {
    return ReceivedNotificationType.invitedTask;
  }
  if (str == "myTodoTask") {
    return ReceivedNotificationType.myTodoTask;
  }
  if (str == "inreviewTask") {
    return ReceivedNotificationType.inreviewTask;
  }
  if (str == "article") {
    return ReceivedNotificationType.article;
  }
  if (str == "distress") {
    return ReceivedNotificationType.distress;
  }

  return ReceivedNotificationType.unKnown;
}

/// Extension to convert ReceivedNotificationType to string
extension ToString on ReceivedNotificationType {
  openRequiredPage(BuildContext context, {required int id}) {
    switch (this) {
      case ReceivedNotificationType.inprogressTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.inprogress,
        );
        break;
      case ReceivedNotificationType.consultation:
        RouteHelper().myConsultations(context, isReplacement: false);
        break;
      case ReceivedNotificationType.tax:
        RouteHelper().myTaxesScreen(context, isReplacement: false);
        break;
      case ReceivedNotificationType.chat:
        // TODO: Handle this case.
        break;
      case ReceivedNotificationType.task:
        //RouteHelper().taskDetails(context, isReplacement: false);
        break;
      case ReceivedNotificationType.completedTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.completed,
        );
        break;
      case ReceivedNotificationType.invitedTask:
        // TODO: Handle this case.
        break;
      case ReceivedNotificationType.myTodoTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.todo,
        );
        break;
      case ReceivedNotificationType.inreviewTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.inreview,
        );
        break;
      case ReceivedNotificationType.article:
        RouteHelper().singleArticleScreen(context, articleId: id);
        break;

      case ReceivedNotificationType.distress:
        RouteHelper().mySosScreen(context);
        break;

      case ReceivedNotificationType.unKnown:
        // TODO: Handle this case.
        break;
    }
  }
}
