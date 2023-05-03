import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/functions/common_functions.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../common/enum/app_error_type.dart';
import '../../../../logic/cubit/get_my_sos/get_my_sos_cubit.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/last_list_item.dart';
import '../../../../widgets/loading_widget.dart';


class LoadingMoreMySosWidget extends StatelessWidget {
  final GetMySosCubit allSosCubit;

  const LoadingMoreMySosWidget({
    Key? key,
    required this.allSosCubit,
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
        child: BlocConsumer<GetMySosCubit, GetMySosState>(
          /// listener
          listener: (context, state) {
            //  show snackBar
            if (state is ErrorWhileGettingMySosList) {
              if (state.appError.appErrorType == AppErrorType.api) {
                showSnackBar(context, message: "تحقق من الاتصال بالنترنت");
              }
            }
          },

          /// builder
          builder: (context, state) {
            //==> LastPageReached
            if (state is LastPageMySosListFetched) {
              return const LastListItem();
            }

            //==> LoadMoreScreensError
            if (state is ErrorWhileGettingMySosList) {
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
