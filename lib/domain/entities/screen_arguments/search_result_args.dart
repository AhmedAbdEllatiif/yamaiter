import 'package:yamaiter/presentation/logic/cubit/search_for_lawyers/search_for_lawyers_cubit.dart';

import '../data/lawyer_entity.dart';

class SearchResultArguments {
  final List<LawyerEntity> lawyersResult;
  final SearchForLawyersCubit searchForLawyersCubit;
  final String governorates;

  SearchResultArguments({
    required this.lawyersResult,
    required this.searchForLawyersCubit,
    required this.governorates,
  });
}
