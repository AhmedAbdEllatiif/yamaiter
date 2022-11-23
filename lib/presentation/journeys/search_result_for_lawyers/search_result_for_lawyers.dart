import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamaiter/common/extensions/size_extensions.dart';
import 'package:yamaiter/domain/entities/screen_arguments/search_result_args.dart';
import 'package:yamaiter/presentation/journeys/search_result_for_lawyers/search_result_item.dart';
import 'package:yamaiter/presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';
import 'package:yamaiter/presentation/widgets/ads_widget.dart';

import '../../../common/constants/app_utils.dart';
import '../../../common/constants/sizes.dart';
import '../../../domain/entities/data/lawyer_entity.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../main/main_page_title.dart';

class SearchResultForLawyers extends StatefulWidget {
  final SearchResultArguments arguments;

  const SearchResultForLawyers({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SearchResultForLawyers> createState() => _SearchResultForLawyersState();
}

class _SearchResultForLawyersState extends State<SearchResultForLawyers> {
  /// SearchForLawyersCubit
  late final SearchForLawyersCubit _searchForLawyersCubit;

  /// result of lawyers
  late final List<LawyerEntity> lawyerResult;

  /// governorates searching in
  late final String _governorates;

  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _searchForLawyersCubit = widget.arguments.searchForLawyersCubit;
    lawyerResult = widget.arguments.lawyersResult;
    _governorates = widget.arguments.governorates;

    /// init cotroller
    _controller = ScrollController();
    _listenerOnScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(
        title: const Text("نتائج البحث"),
      ),

      /// body
      body: Column(
        children: [
          /// adsWidget
          const AdsWidget(),

          /// title with add new Tasks
          Padding(
            padding: EdgeInsets.only(
              top: AppUtils.mainPagesVerticalPadding.h,
              right: AppUtils.mainPagesHorizontalPadding.w,
              left: AppUtils.mainPagesHorizontalPadding.w,
            ),
            child: const MainPageTitle(
              title: "نتائج البحث",
            ),
          ),

          SizedBox(
            height: Sizes.dimen_10.h,
          ),

          /// no result found
          if (lawyerResult.isEmpty)
            const Center(
              child: Text("لا يوجد محامين في هذه المحافظة"),
            ),

          /// result list
          Flexible(
            child: ListView.separated(
              controller: _controller,
              padding: EdgeInsets.symmetric(
                horizontal: AppUtils.mainPagesHorizontalPadding.w,
              ),
              shrinkWrap: true,

              physics: const BouncingScrollPhysics(),

              //==> itemCount
              itemCount: lawyerResult.length,

              //==> separatorBuilder
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: Sizes.dimen_5.h,
                );
              },

              //==> itemBuilder
              itemBuilder: (context, index) {
                return SearchResultItem(lawyerEntity: lawyerResult[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  /// To search for lawyers
  void _searchForLawyers() {
    // init userToken
    final userToken = context.read<UserTokenCubit>().state.userToken;

    _searchForLawyersCubit.searchForLawyer(
      userToken: userToken,
      governorates: _governorates,
      currentListLength: lawyerResult.length,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_searchForLawyersCubit.state is! LastPageSearchForLawyersFetched) {
          _searchForLawyers();
        }
      }
    });
  }
}
