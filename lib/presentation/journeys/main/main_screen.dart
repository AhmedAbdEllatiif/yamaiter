import 'package:flutter/material.dart';
import 'package:yamaiter/presentation/widgets/custom_app_bar.dart';

import '../../themes/theme_color.dart';
import '../drawer/drawer_screen/drawer_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// _scaffoldKey
      key: _scaffoldKey,

      /// appBar
      appBar: CustomAppBar(
        context: context,
        onMenuPressed: () => _openDrawer(),
      ),

      /// drawer
      drawer: DrawerScreen(),

      /// body
      body: const Center(
        child: Text("Main screen"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryDarkColor,
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.white.withOpacity(0.3),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],

        // currentIndex
        currentIndex: _selectedIndex,

        // onTap
        onTap: _onItemTapped,
      ),
    );
  }

  void _openDrawer() {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {}
    setState(() {
      _selectedIndex = index;
    });
  }
}
