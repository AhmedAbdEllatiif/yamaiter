import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/get_authoried_user.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/chat_room_args.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../logic/cubit/authorized_user/authorized_user_cubit.dart';
import '../../widgets/text_with_icon.dart';

class ChatItem extends StatefulWidget {
  final ReceivedChatListEntity receivedChatListEntity;

  const ChatItem({
    Key? key,
    required this.receivedChatListEntity,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  late final String _lastMessageToShow;
  late final LawyerEntity _lawyerEntity;
  late final String _messageDate;
  late final int _chatId;
  late final String _chatChannel;

  @override
  void initState() {
    super.initState();
    //==> _lastMessageToShow
    _lastMessageToShow =
        widget.receivedChatListEntity.lastMessageToShow.chatItemMessage;

    //==> _lawyerEntity
    _lawyerEntity = widget.receivedChatListEntity.lawyerEntity;

    //==> _messageDate
    _messageDate =
        widget.receivedChatListEntity.lastMessageToShow.messageCreatedAt;

    //==> init chatId
    _chatId = widget.receivedChatListEntity.chatId;

    //==> init chatChannel
    _chatChannel = widget.receivedChatListEntity.chatChannel;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        onTap: () => _navigateToChatRoom(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_8.w,
            vertical: Sizes.dimen_8.h,
          ),
          child: Row(
            children: [
              ImageNameRatingWidget(
                imgUrl: _lawyerEntity.profileImage,
                name: _lawyerEntity.firstName,
                nameColor: AppColor.primaryDarkColor,
                rating: _lawyerEntity.rating.toDouble(),
                withRow: false,
                showRating: false,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _lastMessageToShow,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            height: 1.3,
                          ),
                    ),
                    TextWithIconWidget(
                      iconData: Icons.date_range_outlined,
                      iconSize: Sizes.dimen_16.w,
                      text: _messageDate,
                      textStyle: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.accentColor,
                            height: 1.3,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToChatRoom() {

    RouteHelper().chatRoomScreen(context,
        chatRoomArguments: ChatRoomArguments(
          authorizedUserEntity: getAuthorizedUserEntity(context),
          chatRoomId: _chatId,
          chatChannel: _chatChannel,
        ));
  }
}
