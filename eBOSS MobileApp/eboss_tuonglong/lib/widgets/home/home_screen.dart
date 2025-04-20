import 'package:eboss_tuonglong/widgets/UserInfo/userinfo_screen.dart';
import 'package:eboss_tuonglong/widgets/home/appbarbootom_screen.dart';
import 'package:eboss_tuonglong/widgets/home/homeview_screen.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _HomeState_Screen();
}

class _HomeState_Screen extends State<Home_Screen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeViewScreen(),
    //TaskScreen(),
    UserInfoScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: AppBarBootom(onItemTapped: onItemTapped));
  }
}
