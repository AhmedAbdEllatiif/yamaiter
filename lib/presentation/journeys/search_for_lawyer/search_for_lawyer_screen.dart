import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/journeys/search_for_lawyer/choose_governortes_to_search.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

class SearchForLawyerScreen extends StatefulWidget {
  const SearchForLawyerScreen({Key? key}) : super(key: key);

  @override
  State<SearchForLawyerScreen> createState() => _SearchForLawyerScreenState();
}

class _SearchForLawyerScreenState extends State<SearchForLawyerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appBar
      appBar: AppBar(),

      /// body
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.primaryDarkColor,
        child: ChooseGovernoratesToSearch(
          onSearchPressed: (value) {
            print("Search in $value");
          },
        ),
      ),
    );
  }
}
