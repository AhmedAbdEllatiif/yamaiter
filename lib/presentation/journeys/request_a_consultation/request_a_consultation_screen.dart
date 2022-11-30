import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/request_a_consultation/consultation_form.dart';

import '../../../common/constants/app_utils.dart';
import '../../widgets/ads_widget.dart';

class RequestAConsultationScreen extends StatefulWidget {
  const RequestAConsultationScreen({Key? key}) : super(key: key);

  @override
  State<RequestAConsultationScreen> createState() =>
      _RequestAConsultationScreenState();
}

class _RequestAConsultationScreenState
    extends State<RequestAConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("طلب استشارة قانونية"),
      ),

      body: Column(
        children: [
          const AdsWidget(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUtils.mainPagesHorizontalPadding.w,
            ),
            child: ConsultationForm(
              onSuccess: () {},
            ),
          ))
        ],
      ),
    );
  }
}
