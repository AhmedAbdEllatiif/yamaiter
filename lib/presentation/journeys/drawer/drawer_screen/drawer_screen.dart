import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/presentation/journeys/drawer/drawer_screen/drawer_item.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../logic/cubit/auto_login/auto_login_cubit.dart';

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
                   context.read<AutoLoginCubit>().delete();
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
