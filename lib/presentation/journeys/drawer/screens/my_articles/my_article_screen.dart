import 'package:flutter/material.dart';

class MyArticlesScreen extends StatefulWidget {
  const MyArticlesScreen({Key? key}) : super(key: key);

  @override
  State<MyArticlesScreen> createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("My Articles list"),
    );
  }
}
