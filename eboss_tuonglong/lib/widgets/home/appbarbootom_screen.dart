import 'package:flutter/material.dart';
import 'package:eboss_tuonglong/common/LanguageText.dart';



// Phần 1: Lớp định nghĩa item (ĐÃ SỬA)
class CustomBottomNavBarItem {
  final Icon icon;
  final Widget label;
  final Icon? activeIcon;

  // **SỬA LỖI: Thêm 'const' vào hàm khởi tạo**
  const CustomBottomNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

// Phần 2: Widget Bottom Nav Bar tùy chỉnh (Giữ nguyên)
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavBarItem> items;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          final color = isSelected ? selectedColor : unselectedColor;
          final icon = (isSelected && item.activeIcon != null)
              ? item.activeIcon!
              : item.icon;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.translucent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(color: color, size: 25),
                    child: icon,
                  ),
                  const SizedBox(height: 4),
                  // DefaultTextStyle sẽ tự động áp dụng style cho LanguageText
                  DefaultTextStyle(
                    style: TextStyle(
                      color: color,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                    child: item.label,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Phần 3: Áp dụng Widget LanguageText của bạn vào AppBarBootom
class AppBarBootom extends StatefulWidget {
  const AppBarBootom({super.key, required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  State<AppBarBootom> createState() => _AppBarBootomState();
}

class _AppBarBootomState extends State<AppBarBootom> {
  int _indexTab = 0;

  // Không cần các hàm xử lý ngôn ngữ ở đây nữa
  // vì widget LanguageText đã tự xử lý logic đó.

  void _clickOnTab(int index) {
    widget.onItemTapped(index);
    setState(() {
      _indexTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavBar(
      currentIndex: _indexTab,
      onTap: _clickOnTab,
      selectedColor: const Color(0xFF225F59),
      unselectedColor: Colors.black38,
      items: const [
        // **SỬ DỤNG TRỰC TIẾP WIDGET `LanguageText` CỦA BẠN**
        CustomBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: LanguageText(
            nameId: '33',
            defaultValue: 'Trang chủ',
          ),
        ),
        CustomBottomNavBarItem(
          icon: Icon(Icons.window_outlined),
          activeIcon: Icon(Icons.window_rounded),
          label: LanguageText(
            nameId: '35',
            defaultValue: 'Ứng dụng',
          ),
        ),
        CustomBottomNavBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: LanguageText(
            nameId: '2',
            defaultValue: 'Hồ sơ',
          ),
        ),
        // CustomBottomNavBarItem(
        //   icon: Icon(Icons.settings_outlined),
        //   activeIcon: Icon(Icons.settings),
        //   label: LanguageText(
        //     nameId: 'settings',
        //     defaultValue: 'Cài đặt',
        //   ),
        // ),
      ],
    );
  }
}
