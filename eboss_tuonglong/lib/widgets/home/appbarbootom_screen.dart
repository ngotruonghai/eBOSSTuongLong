import 'package:flutter/material.dart';

class AppBarBootom extends StatefulWidget {
  const AppBarBootom({super.key, required this.onItemTapped});

  final onItemTapped;
  @override
  State<AppBarBootom> createState() => _AppBarBootomState();
}

class _AppBarBootomState extends State<AppBarBootom> {
  int IndexTab = 0;

  void clickOnTab(int Index) {
    widget.onItemTapped(Index);
    setState(() {
      IndexTab = Index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white54, width: 1.0)),
      ),
      child: BottomNavigationBar(
        currentIndex: IndexTab,
        backgroundColor: const Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(
          0xFF225F59,
        ), // Set the color of the selected tab
        unselectedItemColor: Colors.black38,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25, // Kích thước icon
            ),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
             icon: Icon(
              Icons.window_rounded,
              size: 25, // Kích thước icon
            ),
            label: "Ứng dụng",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 25, // Kích thước icon
            ),
            label: "Hồ sơ",
          ),
        ],
        onTap: (index) {
          clickOnTab(index);
        },
      ),
    );
  }
}
