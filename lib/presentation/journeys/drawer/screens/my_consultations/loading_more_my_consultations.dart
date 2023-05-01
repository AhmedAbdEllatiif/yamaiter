import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';

import '../../../../../../common/constants/sizes.dart';
import '../../../../../../common/enum/app_error_type.dart';
import '../../../../logic/client_cubit/get_my_consultations/get_my_consultations_cubit.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/last_list_item.dart';
import '../../../../widgets/loading_widget.dart';

class LoadingMoreMyConsultationsWidget extends StatelessWidget {
  final GetMyConsultationsCubit myConsultationsCubit;

  const LoadingMoreMyConsultationsWidget({
    Key? key,
    required this.myConsultationsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Sizes.dimen_10,
          left: Sizes.dimen_10,
          right: Sizes.dimen_10,
          bottom: Sizes.dimen_30),
      child: Center(
        child: BlocConsumer<GetMyConsultationsCubit, GetMyConsultationsState>(
          /// listener
          listener: (context, state) {
            //  show snackBar
            if (state is ErrorWhileGettingMyConsultationsList) {
              if (state.appError.appErrorType == AppErrorType.api) {
                showSnackBar(context, message: "تحقق من الاتصال بالنترنت");
              }
            }
          },

          /// builder
          builder: (context, state) {
            //==> LastPageReached
            if (state is LastPageMyConsultationsListFetched) {
              return const LastListItem();
            }

            //==> LoadMoreScreensError
            if (state is ErrorWhileGettingMyConsultationsList) {
              return Column(
                children: [
                  const LoadingWidget(),
                  Text(
                    "تحقق من الاتصال بالنترنت",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColor.white),
                  ),
                ],
              );
            }

            //==> loading
            return SizedBox(
              child: LoadingWidget(size: Sizes.dimen_40.h),
            );
          },
        ),
      ),
    );
  }
}
