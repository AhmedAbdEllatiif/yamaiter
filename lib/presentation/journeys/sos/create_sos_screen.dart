import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/app_utils.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/sos/sos_form.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../router/route_helper.dart';

class CreateSosScreen extends StatelessWidget {
  const CreateSosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نشر استغاثة"),
      ),
      body: Column(
        children: [
          const AdsWidget(),

          //==> sos form
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppUtils.mainPagesHorizontalPadding.w,
                vertical: AppUtils.mainPagesVerticalPadding.h),
            child: SosForm(
              onSuccess: () {
                RouteHelper().mySosScreen(context, isReplacement: true);
              },
            ),
          )),
        ],
      ),
    );
  }
}
