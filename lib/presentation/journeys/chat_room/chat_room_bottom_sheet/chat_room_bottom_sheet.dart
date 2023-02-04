import 'package:flutter/material.dart';

import '../../../../common/screen_utils/screen_util.dart';
import 'chat_bottom_sheet_item.dart';

class ChatRoomBottomSheet extends StatelessWidget {
  final Function() onSelectImagePressed;
  final Function() onSelectFilePressed;
  final Function() onCancelPressed;

  const ChatRoomBottomSheet({
    Key? key,
    required this.onSelectImagePressed,
    required this.onSelectFilePressed,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: ScreenUtil.screenHeight * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //==> select image
            Expanded(
              child: ChatBottomSheetItem(
                text: "صورة",
                iconData: Icons.image_outlined,
                onPressed: onSelectImagePressed,
              ),
            ),

            //==> select file
            Expanded(
              child: ChatBottomSheetItem(
                text: "ملف",
                iconData: Icons.file_copy_outlined,
                onPressed: onSelectFilePressed,
              ),
            ),

            //==> cancel
            Expanded(
              child: ChatBottomSheetItem(
                text: "الغاء",
                iconData: Icons.close,
                onPressed: onCancelPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
