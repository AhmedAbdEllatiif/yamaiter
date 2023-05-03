import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/chat/received_chat_list_entity.dart';
import 'package:yamaiter/domain/entities/data/lawyer_entity.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/image_name_rating_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../widgets/text_with_icon.dart';

class ChatItem extends StatefulWidget {
  final ReceivedChatListEntity receivedChatListEntity;
  final Function() onItemPressed;

  const ChatItem({
    Key? key,
    required this.receivedChatListEntity,
    required this.onItemPressed,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  late final String _lastMessageToShow;
  late final LawyerEntity _lawyerEntity;
  late final String _messageDate;

  @override
  void initState() {
    super.initState();
    //==> _lastMessageToShow
    _lastMessageToShow =
        widget.receivedChatListEntity.lastMessageToShow.chatItemMessage;

    //==> _lawyerEntity
    _lawyerEntity = widget.receivedChatListEntity.lawyerEntity;

    //==> _messageDate
    String messageCreatedAt =
        widget.receivedChatListEntity.lastMessageToShow.messageCreatedAt;
    DateTime? createdAt = DateTime.tryParse(messageCreatedAt);
    if (createdAt != null) {
      _messageDate =
          "${createdAt.year.toString()}-${createdAt.month.toString().padLeft(2, '0')}-"
          "${createdAt.day.toString().padLeft(2, '0')} "
          " ${createdAt.hour.toString().padLeft(2, '0')}:"
          "${createdAt.minute.toString().padLeft(2, '0')}";
    } else {
      _messageDate = AppUtils.undefined;
    }

    //==> init chatId

    //==> init chatChannel
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppUtils.cornerRadius),
        onTap: widget.onItemPressed,
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

              // if no message show start chat
              _lastMessageToShow == AppUtils.undefined &&
                      _messageDate == AppUtils.undefined
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "ابدء المحادثة الان",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _lastMessageToShow,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      height: 1.3,
                                    ),
                          ),
                          TextWithIconWidget(
                            iconData: Icons.date_range_outlined,
                            iconSize: Sizes.dimen_16.w,
                            text: _messageDate,
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
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
}
