import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/functions/get_user_token.dart';
import 'package:yamaiter/di/git_it_instance.dart';
import 'package:yamaiter/domain/entities/data/sos_entity.dart';
import 'package:yamaiter/domain/entities/screen_arguments/single_sos_screen_args.dart';
import 'package:yamaiter/presentation/journeys/sos/single_sos_details/single_sos_details_widget.dart';
import 'package:yamaiter/presentation/logic/cubit/get_single_sos/get_single_sos_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../../common/enum/app_error_type.dart';
import '../../../../common/functions/navigate_to_login.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class SingleSosScreen extends StatefulWidget {
  final SingleScreenArguments singleScreenArguments;

  const SingleSosScreen({Key? key, required this.singleScreenArguments})
      : super(key: key);

  @override
  State<SingleSosScreen> createState() => _SingleSosScreenState();
}

class _SingleSosScreenState extends State<SingleSosScreen> {
  late final GetSingleSosCubit _getSingleSosCubit;

  late final SosEntity? sosEntity;
  late final int sosId;

  @override
  void initState() {
    super.initState();
    sosEntity = widget.singleScreenArguments.sosEntity;
    sosId = widget.singleScreenArguments.sosId ?? -1;

    _getSingleSosCubit = getItInstance<GetSingleSosCubit>();
    if (sosId != -1) {
      _fetchSingleSos();
    }
  }

  @override
  void dispose() {
    _getSingleSosCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getSingleSosCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("استغاثة"),
        ),
        body: Column(
          children: [
            /// Ads ListView
            const AdsWidget(),

            sosEntity != null
                ? SingleSosDetailsWidget(
                    sosEntity: sosEntity!,
                    withCallButton: widget.singleScreenArguments.withCallButton,
                  )
                : BlocBuilder<GetSingleSosCubit, GetSingleSosState>(
                    builder: (context, state) {
                      /*
                        *
                        *
                        *
                        *
                        *
                        * */
                      if (state is LoadingSingleSos) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      }

                      /*
                        *
                        *
                        * UnAuthenticated
                        *
                        *
                        * */
                      if (state is UnAuthenticatedToFetchSingleSos) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: AppErrorType.unauthorizedUser,
                            onPressedRetry: () {
                              navigateToLogin(context);
                            },
                          ),
                        );
                      }

                      /*
                        *
                        *
                        * error
                        *
                        *
                        * */
                      if (state is ErrorWhileFetchingSingleSos) {
                        return Center(
                          child: AppErrorWidget(
                            appTypeError: state.appError.appErrorType,
                            onPressedRetry: () {
                              navigateToLogin(context);
                            },
                          ),
                        );
                      }

                      /*
                        *
                        *
                        * success
                        *
                        *
                        * */
                      if (state is SosFetchedSuccessfully) {
                        return SingleSosDetailsWidget(
                          sosEntity: state.sosEntity,
                          withCallButton:
                              widget.singleScreenArguments.withCallButton,
                        );
                      }

                      /// else
                      return const SizedBox.shrink();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  /// to fetch sos
  void _fetchSingleSos() {
    _getSingleSosCubit.tryToFetchSingleSos(
      sosId: sosId,
      userToken: getUserToken(context),
    );
  }
}
