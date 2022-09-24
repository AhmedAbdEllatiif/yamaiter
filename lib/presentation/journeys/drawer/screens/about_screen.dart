import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/constants/sizes.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/drawer_screen_item.dart';
import 'package:yamaiter/presentation/logic/cubit/about/about_cubit.dart';
import 'package:yamaiter/presentation/logic/cubit/user_token/user_token_cubit.dart';
import 'package:yamaiter/presentation/widgets/app_error_widget.dart';
import 'package:yamaiter/presentation/widgets/loading_widget.dart';

import '../../../widgets/custom_app_bar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final AboutCubit _aboutCubit;

  @override
  void initState() {
    super.initState();
    _aboutCubit = getItInstance<AboutCubit>();
    _fetchAbout();
  }

  @override
  void dispose() {
    _aboutCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _aboutCubit,
      child: Scaffold(
        /// appBar
        appBar: AppBar(
          title: const Text("من نحن"),
        ),

        body: BlocBuilder<AboutCubit, AboutState>(
          builder: (_, state) {
            /// loading
            if (state is LoadingAbout) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /// unAuthorized
            if (state is UnAuthorizedAbout) {
              return const Center(
                child: Text("User UnAuthorized"),
              );
            }

            /// error
            if (state is ErrorWhileGettingAbout) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchAbout(),
                ),
              );
            }

            /// fetched
            if (state is AboutFetchedSuccess) {
              final aboutList = state.aboutList;
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, index) =>
                    SizedBox(height: Sizes.dimen_10.h),
                itemCount: aboutList.length,
                itemBuilder: (_, index) {
                  return DrawerScreenItem(
                    title: aboutList[index].title,
                    sections: aboutList[index].sections,
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
    _aboutCubit.getAppAbout(userToken);
  }
}
