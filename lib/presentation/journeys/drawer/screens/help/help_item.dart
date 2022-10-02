import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/help_question_entity.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../widgets/app_content_title_widget.dart';
import 'help_expansion_item.dart';

class HelpScreenItem extends StatelessWidget {
  final HelpQuestionEntity questionEntity;

  const HelpScreenItem({Key? key, required this.questionEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Theme(
        /// theme data
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),

        /// child
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==> title
            AppContentTitleWidget(title: questionEntity.title),

            SizedBox(
              height: Sizes.dimen_8.h,
            ),

            ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                ExpansionPanelList.radio(
                  elevation: 0.0,
                  animationDuration: const Duration(milliseconds: 500),
                  children: questionEntity.questions.map((question) {
                    return HelpExpansionPanelRadio(
                        title: question.title, content: question.answer);
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
