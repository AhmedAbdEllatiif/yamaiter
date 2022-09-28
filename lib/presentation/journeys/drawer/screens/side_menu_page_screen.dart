import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/side_menu_page_item.dart';
import 'package:yamaiter/presentation/logic/cubit/side_menu_page/side_menu_page_cubit.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/screen_arguments/side_menu_page_args.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class SideMenuPageScreen extends StatefulWidget {
  final SideMenuPageArguments sideMenuPageArguments;

  const SideMenuPageScreen({Key? key, required this.sideMenuPageArguments})
      : super(key: key);

  @override
  State<SideMenuPageScreen> createState() => _SideMenuPageScreenState();
}

class _SideMenuPageScreenState extends State<SideMenuPageScreen> {
  late final SideMenuPageCubit _sideMenuPageCubit;

  @override
  void initState() {
    super.initState();
    _sideMenuPageCubit = getItInstance<SideMenuPageCubit>();
    _fetchAbout();
  }

  @override
  void dispose() {
    _sideMenuPageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _sideMenuPageCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title:  Text(widget.sideMenuPageArguments.pageTitle),
        ),

        body: BlocBuilder<SideMenuPageCubit, SideMenuPageState>(
          builder: (_, state) {
            /// loading
            if (state is LoadingSideMenuPage) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /// unAuthorized
            if (state is UnAuthorizedSideMenuPage) {
              return const Center(
                child: Text("User UnAuthorized"),
              );
            }

            /// error
            if (state is ErrorWhileGettingSideMenuPage) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchAbout(),
                ),
              );
            }

            /// fetched
            if (state is SideMenuPageFetchedSuccess) {
              final termsList = state.sideMenuPages;
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, index) =>
                    SizedBox(height: Sizes.dimen_10.h),
                itemCount: termsList.length,
                itemBuilder: (_, index) {
                  return SideMenuPageItem(
                    title: termsList[index].title,
                    sections: termsList[index].sections,
                  );
                },
              );
            }

            /// nothing to show
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _fetchAbout() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    // request about
    _sideMenuPageCubit.getAppSideMenuData(
        userToken: userToken, sideMenuPage: widget.sideMenuPageArguments.sideMenuPage);
  }
}
