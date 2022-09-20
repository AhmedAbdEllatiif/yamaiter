import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: const Center(
        child: Text("Main screen"),
      ),
    );
  }
}
