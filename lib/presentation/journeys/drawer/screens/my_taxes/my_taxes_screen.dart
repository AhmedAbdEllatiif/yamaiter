import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/di/git_it.dart';
import 'package:yamaiter/domain/entities/screen_arguments/add_tax_args.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/completed_taxes/completed_taxes.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/in_progress_taxes/in_progress_taxes.dart';
import 'package:yamaiter/presentation/journeys/drawer/screens/my_taxes/tax_item.dart';
import 'package:yamaiter/presentation/logic/cubit/create_tax/create_tax_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';
import 'package:yamaiter/router/route_helper.dart';

import '../../../../../common/constants/app_utils.dart';
import '../../../../../common/constants/assets_constants.dart';
import '../../../../../common/constants/sizes.dart';
import '../../../../../domain/entities/data/ad_entity.dart';
import '../../../../logic/cubit/get_in_progress_taxes/get_in_progress_taxes_cubit.dart';
import '../../../../widgets/ads_list/ads_list_view.dart';
import '../../../../widgets/tab_bar/tab_bar_widget.dart';
import '../../../../widgets/title_with_add_new_item.dart';

class MyTaxesScreen extends StatefulWidget {
  const MyTaxesScreen({Key? key}) : super(key: key);

  @override
  State<MyTaxesScreen> createState() => _MyTaxesScreenState();
}

class _MyTaxesScreenState extends State<MyTaxesScreen>
    with SingleTickerProviderStateMixin {
  late final CreateTaxCubit _createTaxCubit;

  /// TabController
  late final TabController _tabController;

  /// current tab selected index
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _createTaxCubit = getItInstance<CreateTaxCubit>();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _createTaxCubit.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _createTaxCubit,
      child: BlocListener<CreateTaxCubit, CreateTaxState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Scaffold(
          /// appBar
          appBar: AppBar(
            title: const Text("اقرارتى الضريبية"),
          ),

          body: Padding(
            padding: EdgeInsets.only(
                //horizontal: AppUtils.mainPagesHorizontalPadding.w,
                top: AppUtils.mainPagesVerticalPadding.h),
            child: Column(
              children: [
                /// Ads ListView
                const AdsWidget(),

                /// title with add new
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Sizes.dimen_16.h,
                        bottom: AppUtils.mainPagesVerticalPadding.h,
                        ),
                    child: Column(
                      children: [
                        /// title with add new sos
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppUtils.mainPagesHorizontalPadding.w,
                          ),
                          child: TitleWithAddNewItem(
                            title: "اقرارتى الضريبية",
                            addText: "طلب إقرار ضريبى",
                            onAddPressed: () =>
                                _navigateToAddNewTaxScreen(context),
                          ),
                        ),

                        SizedBox(
                          height: Sizes.dimen_10.h,
                        ),

                        ///TabBar widget
                        TabBarWidget(
                          currentSelectedIndex: currentIndex,
                          tabController: _tabController,
                          onTabPressed: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),

                        /// list of my sos
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              height: ScreenUtil.screenHeight * 0.60,
                              child: TabBarView(
                                //physics: NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  /// InProgressTaxesList
                                  InProgressTaxesList(
                                    createTaxCubit: _createTaxCubit,
                                  ),

                                  /// CompletedTaxesList
                                  const CompletedTaxesList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// bottom space
                //SizedBox(height: Sizes.dimen_20.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// to navigate to add new tax screen
  void _navigateToAddNewTaxScreen(BuildContext context) =>
      RouteHelper().addNewTaxScreen(context,
          addTaxArguments: AddTaxArguments(createTaxCubit: _createTaxCubit));
}
