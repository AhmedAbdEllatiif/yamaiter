import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class TabBarWidget extends StatelessWidget {
  final Function(int) onTabPressed;
  final int currentSelectedIndex;
  final TabController tabController;
  final double? tabItemHeight;
  final List<Widget> tabs;

  const TabBarWidget({
    Key? key,
    required this.tabs,
    this.tabItemHeight,
    required this.onTabPressed,
    required this.currentSelectedIndex,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      //This is responsible for the background of the tabbar, does the magic
      decoration: const BoxDecoration(
        //This is for background color
        color: AppColor.primaryDarkColor,
        //This is for bottom border that is needed
        //border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8)),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColor.white,
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.bold),

        labelColor: AppColor.white,
        labelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.bold),

        //splashBorderRadius: BorderRadius.circular(50.0),

        /// indicator
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(
          color: AppColor.accentColor,
        ),

        /// onTabPressed
        onTap: onTabPressed,

        /// list of tabs
        tabs: tabs
      ),
    );
  }
}
