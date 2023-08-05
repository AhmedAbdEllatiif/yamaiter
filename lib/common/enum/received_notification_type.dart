import 'package:flutter/cupertino.dart';
import 'package:yamaiter/common/enum/task_status.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_task_details_params.dart';
import 'package:yamaiter/domain/entities/screen_arguments/task_details_args.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../domain/entities/screen_arguments/chat_room_args.dart';
import '../functions/get_authoried_user.dart';

enum ReceivedNotificationType {
  inprogressTask,
  consultation,
  tax,
  chat,
  singleTask,
  myPostedTask,
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
  if (str == "singleTask") {
    return ReceivedNotificationType.singleTask;
  }

  if (str == "myPostedTask") {
    return ReceivedNotificationType.myPostedTask;
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
  openRequiredPage(
    BuildContext context, {
    required int id,
    String chatChannel = "",
  }) {
    switch (this) {
      /// inprogressTask
      case ReceivedNotificationType.inprogressTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.inprogress,
        );
        break;

      /// consultation
      case ReceivedNotificationType.consultation:
        RouteHelper().myConsultations(context, isReplacement: false);
        break;

      /// tax
      case ReceivedNotificationType.tax:
        RouteHelper().myTaxesScreen(context, isReplacement: false);
        break;

      /// chat
      case ReceivedNotificationType.chat:
        RouteHelper().chatRoomScreen(
          context,
          chatRoomArguments: ChatRoomArguments(
            chatChannel: chatChannel,
            chatRoomId: id,
            authorizedUserEntity: getAuthorizedUserEntity(context),
          ),
        );
        break;

      /// task
      case ReceivedNotificationType.singleTask:
        RouteHelper().taskDetails(
          context,
          taskDetailsArguments: TaskDetailsArguments(
            taskId: id,
            isAlreadyApplied: true,
          ),
        );
        break;

      /// task
      case ReceivedNotificationType.myPostedTask:
        RouteHelper().singleTask(
          context,
          mySingleTaskArguments: MySingleTaskArguments(
            taskId: id,
          ),
        );
        break;

      /// completedTask
      case ReceivedNotificationType.completedTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.completed,
        );
        break;

      /// invitedTask
      case ReceivedNotificationType.invitedTask:
        RouteHelper().invitedTasksScreen(context);
        break;

      /// myTodoTask
      case ReceivedNotificationType.myTodoTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.todo,
        );
        break;

      /// inreviewTask
      case ReceivedNotificationType.inreviewTask:
        RouteHelper().myTasks(
          context,
          isPushNamedAndRemoveUntil: true,
          taskType: TaskType.inreview,
        );
        break;

      /// article
      case ReceivedNotificationType.article:
        RouteHelper().singleArticleScreen(context, articleId: id);
        break;

      /// distress
      case ReceivedNotificationType.distress:
        RouteHelper().singleSosScreen(
          context,
          arguments: SingleScreenArguments(
            sosId: id,
            withCallButton: true,
          ),
        );
        break;

      /// unKnown
      case ReceivedNotificationType.unKnown:
        // TODO: Handle this case.
        break;
    }
  }
}
