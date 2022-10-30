import 'package:flutter/material.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/data/accept_terms_entity.dart';
import 'package:yamaiter/presentation/widgets/app_button.dart';
import 'package:yamaiter/presentation/widgets/scrollable_app_card.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';
import 'app_check_box.dart';
import 'app_content_title_widget.dart';

class AcceptTermsWidget extends StatefulWidget {
  final AcceptTermsEntity acceptTermsEntity;

  const AcceptTermsWidget({Key? key, required this.acceptTermsEntity})
      : super(key: key);

  @override
  State<AcceptTermsWidget> createState() => _AcceptTermsWidgetState();
}

class _AcceptTermsWidgetState extends State<AcceptTermsWidget> {
  bool _isTermsAccepted = false;
  bool _showCheckBoxError = false;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollableAppCard(
      scrollController: _scrollController,

      /// title
      title: const AppContentTitleWidget(
        title: "اتفاقية المعاملة القانونية",
        textColor: AppColor.primaryDarkColor,
      ),

      /// bottom
      bottomChild: AppButton(
        text: "إذهب لاضافة بيانات المهمة المطلوبة",
        width: double.infinity,
        color: AppColor.accentColor,
        textColor: AppColor.primaryDarkColor,
        onPressed: () {
          if (_validateCheckBox(context)) {
            print("Valid");
          }
        },
      ),

      /// child
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => SizedBox(height: Sizes.dimen_10.h),
        itemCount: widget.acceptTermsEntity.pages[0].sections.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Text(
                widget.acceptTermsEntity.pages[0].sections[index].description,
                overflow: TextOverflow.clip,
                //maxLines: 500,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.primaryDarkColor,
                    ),
              ),

              //==> space
              SizedBox(height: Sizes.dimen_8.h),

              // checkBox
              AppCheckBoxTile(
                onChanged: (isChecked) {
                  final currentValue = isChecked ?? false;
                  if (currentValue) {
                    setState(() {
                      _showCheckBoxError = false;
                    });
                  }
                  _isTermsAccepted = currentValue;
                },
                hasError: _showCheckBoxError,
                text:
                    "اوافق على شروط الاتفاقية و اتحمل كامل المسؤولية القانونية",
              ),
            ],
          );
        },
      ),
    );
  }

  /// validate checkbox selection
  bool _validateCheckBox(BuildContext context) {
    if (!_isTermsAccepted) {
      setState(() {
        _showCheckBoxError = true;
        _scrollToBottom();
      });
      return false;
    }

    setState(() {
      _showCheckBoxError = false;
    });
    return true;
  }

  /// to scroll to the bottom
  void _scrollToBottom() => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
}
