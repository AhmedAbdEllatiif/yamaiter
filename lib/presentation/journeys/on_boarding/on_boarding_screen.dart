import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/data/data_source/remote_data_source.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/app_logo.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../common/constants/assets_constants.dart';
import '../../../common/constants/sizes.dart';
import '../../logic/cubit/first_launch/first_launch_cubit.dart';
import 'on_boarding_page_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    _initScreenUtil();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageController.addListener(() {});
    return Scaffold(
      // /*bottomSheet: Container(
      //   color: AppColor.white,
      //   height: ScreenUtil.screenHeight * 0.20,
      // ),*/
      body: Stack(children: [
        PageView(
          controller: pageController,
          onPageChanged: (position) {
            setState(() {
              if (position == 2) {
                showButton = true;
              } else {
                showButton = false;
              }
            });
          },
          children: const [
            OnBoardingPageItem(
              imgPath: AssetsImages.slide1,
            ),
            OnBoardingPageItem(
              imgPath: AssetsImages.slide2,
            ),
            OnBoardingPageItem(
              imgPath: AssetsImages.slide3,
            ),
          ],
        ),
        Positioned(
          bottom: ResponsiveValue(context,
              defaultValue: Sizes.dimen_40.h,
              valueWhen: [
                Condition.largerThan(
                    name: TABLET, value: ScreenUtil.screenHeight * 0.22),
                Condition.equals(
                    name: TABLET, value: ScreenUtil.screenHeight * 0.22),
                Condition.equals(
                    name: MOBILE, value: ScreenUtil.screenHeight * 0.14),
                Condition.equals(
                    name: "S", value: ScreenUtil.screenHeight * 0.15),
              ]).value,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red.withOpacity(.4),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: CustomizableEffect(
                    activeDotDecoration: DotDecoration(
                      width: Sizes.dimen_16.w,
                      height: Sizes.dimen_16.w,
                      color: AppColor.accentColor,
                      // rotationAngle: 180,
                      // verticalOffset: -10,
                      borderRadius: BorderRadius.circular(24),
                      // dotBorder: DotBorder(
                      //   padding: 2,
                      //   width: 2,
                      //   color: Colors.indigo,
                      // ),
                    ),
                    dotDecoration: DotDecoration(
                      width: Sizes.dimen_10.w,
                      height: Sizes.dimen_10.w,
                      color: Colors.grey,
                      // dotBorder: DotBorder(
                      //   padding: 2,
                      //   width: 2,
                      //   color: Colors.grey,
                      // ),
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(2),
                      //     topRight: Radius.circular(16),
                      //     bottomLeft: Radius.circular(16),
                      //     bottomRight: Radius.circular(2)),
                      borderRadius: BorderRadius.circular(16),
                      verticalOffset: 0,
                    ),
                    //spacing: 6.0,
                    // activeColorOverride: (i) => colors[i],
                    inActiveColorOverride: (i) => AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showButton)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.dimen_8.h,
                  right: Sizes.dimen_15.w,
                  left: Sizes.dimen_15.w),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(
                        bottom: Sizes.dimen_8.h,
                        right: Sizes.dimen_4.w,
                        left: Sizes.dimen_4.w),
                    child: AppButton(
                      text: "ابدء الان",
                      textColor: AppColor.primaryDarkColor,
                      color: AppColor.accentColor,
                      withAnimation: true,
                      onPressed: () {
                        // change first launch state
                        _changeAppFirstLaunchStatus();

                        // navigate to choose user type
                        _navigateToChooseUserTypeScreen();
                      },
                    ),
                  )),
                ],
              ),
            ),
          )
      ]),
    );
  }

  void _navigateToChooseUserTypeScreen() =>
      RouteHelper().chooseUserType(context);

  void _changeAppFirstLaunchStatus() async {
    await context.read<FirstLaunchStatusCubit>().changeFirstLaunchStatus();
  }

  /// to ensure init ScreenUtil
  void _initScreenUtil() {
    if (ScreenUtil.screenHeight == 0) {
      ScreenUtil.init();
      /*final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;
      final padding = MediaQuery.of(context).padding;
      final aspectRatio = MediaQuery.of(context).devicePixelRatio;
      final textScaleFactor = MediaQuery.of(context).textScaleFactor;
      final widthInPixels = w * aspectRatio;
      final heightInPixels = h * aspectRatio;
      ScreenUtil.initWithMediaQuery(
        height: h,
        width: w,
        pixelRatio: aspectRatio,
        padding: padding,
        screenHeight: heightInPixels,
        screenWidth: widthInPixels,
        textScaleFactor: textScaleFactor,
      );*/
    }
  }
}
