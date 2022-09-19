import 'package:flutter/material.dart';

import '../../common/extensions/size_extensions.dart';
import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class LoginOrRegisterWidget extends StatelessWidget {
  final bool isLogin;
  final Function() onPressed;
  final Function()? onForgetPasswordPressed;

  const LoginOrRegisterWidget({
    Key? key,
    required this.isLogin,
    required this.onPressed,
    this.onForgetPasswordPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (isLogin)
          InkWell(
            onTap: onForgetPasswordPressed,
            splashColor: AppColor.accentColor.withOpacity(0.5),
            hoverColor: AppColor.accentColor.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
            child: Padding(
              padding: EdgeInsets.all(Sizes.dimen_5.w),
              child: Text("نسيت كلمة المرور؟",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      )),
            ),
          ),
        if (!isLogin)
          Text("لديك حساب بالفعل؟",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    letterSpacing: 0,
                    color: AppColor.white,
                    fontWeight: FontWeight.normal,
                  )),
        InkWell(
          onTap: onPressed,
          splashColor: AppColor.accentColor.withOpacity(0.5),
          hoverColor: AppColor.accentColor.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
          child: Padding(
            padding: EdgeInsets.all(Sizes.dimen_5.w),
            child: Text(isLogin ? "تسجيل حساب جديد" : "قم بتسجيل الدخول",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      color: AppColor.accentColor,
                    )),
          ),
        )
      ],
    );
  }
}
