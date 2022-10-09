import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/article/create_article/article_form.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../domain/entities/screen_arguments/add_article_args.dart';

class AddArticleScreen extends StatelessWidget {
  final AddArticleArguments addArticleArguments;
  const AddArticleScreen({Key? key, required this.addArticleArguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,

      /// appBar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: ArticleForm(
            withWithCard: false,
            createArticleCubit: addArticleArguments.createArticleCubit,
            onSuccess: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
