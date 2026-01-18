import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 2,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0, // shadow kita handle sendiri
        selectedItemColor: const Color(0xFF000000),
        unselectedItemColor: const Color(0xFF777777),
        showUnselectedLabels: true,
        items: [
          _navItem(
            icon: 'assets/icons/home.png',
            label: 'Home',
            isActive: currentIndex == 0,
          ),
          _navItem(
            icon: 'assets/icons/deep_read.png',
            label: 'Deep Read',
            isActive: currentIndex == 1,
          ),
          _navItem(
            icon: 'assets/icons/map.png',
            label: 'Map',
            isActive: currentIndex == 2,
          ),
          _navItem(
            icon: 'assets/icons/profile.png',
            label: 'Profile',
            isActive: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required String icon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Image.asset(
        icon,
        width: 24,
        height: 24,
        color: isActive ? const Color(0xFF000000) : const Color(0xFF777777),
      ),
    );
  }
}
