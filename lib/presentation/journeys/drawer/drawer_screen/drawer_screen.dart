import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_screen/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../common/constants/sizes.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryDarkColor,
      child: Column(
        children: [
          Container(
            color: AppColor.green,
            height: ScreenUtil.screenHeight * 0.15,
          ),

          Expanded(
            child: ListView(
              children: [
                 DrawerItem(iconData: Icons.shopping_bag, title: "مهماتى", onPressed: () {  },),
                 DrawerItem(iconData: Icons.list_alt_outlined, title: "منشوراتى", onPressed: () {  },),
                 DrawerItem(iconData: Icons.surround_sound, title: "إعلاناتى", onPressed: () {  },),
                 DrawerItem(iconData: Icons.shopping_bag, title: "اقراراتى الضريبية", onPressed: () {  },),
                 DrawerItem(iconData: Icons.sos, title: "نداءات الاستغاثة", onPressed: () {  },),
                 DrawerItem(iconData: Icons.chat, title: "المحادثات", onPressed: () {  },),
                 DrawerItem(iconData: Icons.settings_outlined, title: "الاعدادت", onPressed: () {  },),
                 DrawerItem(iconData: Icons.info_outline, title: "من نحن", onPressed: () {  },),
                 DrawerItem(iconData: Icons.shield_outlined, title: "سياسة الخصوصية", onPressed: () {  },),
                 DrawerItem(iconData: Icons.shield_outlined, title: "شروط الاستخدام", onPressed: () {  },),
                 DrawerItem(iconData: Icons.question_mark_outlined, title: "اتصل بنا", onPressed: () {  },),
                 DrawerItem(iconData: Icons.logout_outlined, title: "تسجيل الخروج", onPressed: () {
                   context.read<UserTokenCubit>().delete();
                   RouteHelper().loginScreen(context, isClearStack: true);
                 },),
              ],
            ),
          )
        ],
      ),
    );
  }
}
