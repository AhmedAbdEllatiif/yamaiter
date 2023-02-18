import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/enum/app_error_type.dart';
import '../../common/functions/get_user_token.dart';
import '../../di/git_it_instance.dart';
import '../logic/common/get_balance/get_balance_cubit.dart';
import '../themes/theme_color.dart';
import 'app_error_widget.dart';
import 'loading_widget.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  /// GetBalanceCubit
  late final GetBalanceCubit _balanceCubit;

  @override
  void initState() {
    super.initState();
    _balanceCubit = getItInstance<GetBalanceCubit>();
    _fetchCurrentBalance();
  }

  @override
  void dispose() {
    _balanceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _balanceCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<GetBalanceCubit, GetBalanceState>(
          builder: (context, state) {
            /**
             *
             *
             * loading balance
             *
             *
             * */
            if (state is LoadingBalance) {
              return const Center(
                child: LoadingWidget(
                  size: 30,
                ),
              );
            }

            /**
             *
             *
             * no balance
             *
             *
             * */
            if (state is UserHaveNoBalance) {
              return RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "الرصيد الحالى: ",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColor.white)),
                  TextSpan(
                      text: "0",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          )),
                  TextSpan(
                      text: " جنيه",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColor.white))
                ]),
              );
            }

            /**
             *
             *
             * success
             *
             *
             * */
            if (state is BalanceFetchedSuccessfully) {
              return RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "الرصيد الحالى: ",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColor.white)),
                  TextSpan(
                      text: state.balanceEntity.currentBalance.toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          )),
                  TextSpan(
                      text: " جنيه",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColor.white))
                ]),
              );
            }

            return const SizedBox.shrink();
          },
        );
      }),
    );
  }

  void _fetchCurrentBalance() {
    final userToken = getUserToken(context);
    _balanceCubit.tryToGetUserBalance(userToken: userToken);
  }
}
