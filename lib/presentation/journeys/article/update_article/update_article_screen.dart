import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/article/update_article/update_article_form.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../domain/entities/screen_arguments/update_article_args.dart';
import '../../../themes/theme_color.dart';

class UpdateArticleScreen extends StatelessWidget {
  final UpdateArticleArguments updateArticleArguments;

  const UpdateArticleScreen({Key? key, required this.updateArticleArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: UpdateArticleForm(
            withWithCard: false,
            articleEntity: updateArticleArguments.articleEntity,
            userToken: updateArticleArguments.userToken,
            updateArticleCubit: updateArticleArguments.updateArticleCubit,
            onSuccess: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
