import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/help/help_item.dart';
import 'package:yamaiter/presentation/logic/cubit/help/get_help_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../../di/git_it_instance.dart';
import '../../../../logic/cubit/user_token/user_token_cubit.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late final GetHelpCubit _getHelpCubit;

  void _fetchHelp() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _getHelpCubit.getAppHelp(userToken: userToken);
  }

  @override
  void initState() {
    super.initState();
    _getHelpCubit = getItInstance<GetHelpCubit>();
    _fetchHelp();
  }

  @override
  void dispose() {
    _getHelpCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getHelpCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("المساعدة"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_12.h, horizontal: Sizes.dimen_12.w),
          child: BlocBuilder<GetHelpCubit, GetHelpState>(
              builder: (context, state) {
            /// loading
            if (state is LoadingGetHelp) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /// empty
            if (state is EmptyHelp) {
              return const Center(
                child: Text("لايوجد"),
              );
            }

            /// error
            if (state is ErrorWhileGettingHelp) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchHelp(),
                ),
              );
            }

            /// fetched
            if (state is HelpFetchedSuccess) {
              final fetchedList = state.questionsEntities;
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: fetchedList.length,

                /// separatorBuilder
                separatorBuilder: (context, index) => SizedBox(
                  height: Sizes.dimen_10.h,
                ),

                /// itemBuilder
                itemBuilder: (context, index) {
                  return HelpScreenItem(questionEntity: fetchedList[index]);
                },
              );
            }

            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
