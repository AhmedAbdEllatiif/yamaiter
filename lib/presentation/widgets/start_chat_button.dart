import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/screen_arguments/chat_room_args.dart';
import 'package:yamaiter/presentation/widgets/rounded_text.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../common/constants/app_utils.dart';
import '../../common/functions/common_functions.dart';
import '../../common/functions/get_authoried_user.dart';
import '../../domain/entities/data/authorized_user_entity.dart';
import '../themes/theme_color.dart';

class StartChatButton extends StatelessWidget {
  final int chatRoomId;
  final String chatChannel;

  const StartChatButton(
      {Key? key, required this.chatRoomId, required this.chatChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedText(
      text: "ابدأ المحادثة",
      rightIconData: Icons.chat_bubble_outline,
      onPressed: () => _navigateToChatRoom(context),
    );
  }

  void _navigateToChatRoom(BuildContext context) {
    if (chatRoomId == -1 || chatChannel == AppUtils.undefined) {
      log("ChatRoomId >> $chatRoomId, chatChannel: $chatChannel");
      showSnackBar(
        context,
        message: "حدث خطأ لا يمكن بدء المحادثة",
        backgroundColor: AppColor.accentColor,
        isFloating: false,
      );
    } else {
      RouteHelper().chatRoomScreen(
        context,
        chatRoomArguments: ChatRoomArguments(
            authorizedUserEntity: getAuthorizedUserEntity(context),
            chatRoomId: chatRoomId,
            chatChannel: chatChannel),
      );
    }
  }
}
