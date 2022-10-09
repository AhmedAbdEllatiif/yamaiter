import 'package:flutter/cupertino.dart';

class CompletedTaxesList extends StatefulWidget {
  const CompletedTaxesList({Key? key}) : super(key: key);

  @override
  State<CompletedTaxesList> createState() => _CompletedTaxesListState();
}

class _CompletedTaxesListState extends State<CompletedTaxesList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Not Implemented yet"),
    );
  }

  @override

  bool get wantKeepAlive => true;
}
