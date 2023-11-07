import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routing/AppRoutes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;
  final RxDouble iconSize = 24.0.obs;
  final Function(int) onSelected;
  final Function(int) onItemTapped; // Callback for item tap

  CustomBottomNavigationBar({required this.onSelected, required this.onItemTapped});

  void _onItemTapped(int index) {
    selectedIndex.value = index;
    iconSize.value = 28.0;
    _resetIconSize();

    onSelected(index); // Call the onSelected callback
    onItemTapped(index); // Call the onItemTapped callback

    // You don't need to navigate here, as the PageView in your CommonLayout
    // handles the screen changes based on the selectedTabIndex.
  }

  void _resetIconSize() {
    Future.delayed(Duration(milliseconds: 300), () {
      iconSize.value = 24.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex.value,
        selectedItemColor: selectedIndex.value == 0 ? Colors.deepOrangeAccent : Colors.grey,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        items: <BottomNavigationBarItem>[
          _buildAnimatedItem(0, Icons.home, 'Home'),
          _buildAnimatedItem(1, Icons.shop, 'Orders History'),
          _buildAnimatedItem(2, Icons.person, 'Profile'),
          _buildAnimatedItem(3, Icons.settings, 'Settings'),
        ],
        onTap: (index) {
          _onItemTapped(index);
        },
      );
    });
  }

  BottomNavigationBarItem _buildAnimatedItem(int index, IconData icon, String label) {
    final isCurrentItem = selectedIndex.value == index;
    final color = isCurrentItem ? Colors.deepOrangeAccent : Colors.grey;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isCurrentItem ? iconSize.value : 24.0,
        height: isCurrentItem ? iconSize.value : 24.0,
        child: Icon(
          icon,
          size: isCurrentItem ? iconSize.value : 24.0,
          color: color,
        ),
      ),
      label: label,
    );
  }
}
