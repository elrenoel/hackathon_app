import 'package:flutter/material.dart';
import 'package:hackathon_app/color/app_colors.dart';
import 'package:hackathon_app/pages/focus_session.dart';

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
    return SafeArea(
      child: SizedBox(
        height: 90,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background navbar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.violet100,
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(
                        icon: 'assets/icons/home.png',
                        label: 'Home',
                        isActive: currentIndex == 0,
                        onTap: () => onTap(0),
                      ),

                      _navItem(
                        icon: 'assets/icons/deepRead.png',
                        label: 'Deep Read',
                        isActive: currentIndex == 1,
                        onTap: () => onTap(1),
                      ),

                      const SizedBox(width: 30),
                      // space buat tombol tengah
                      _navItem(
                        icon: 'assets/icons/map.png',
                        label: 'Performance',
                        isActive: currentIndex == 2,
                        onTap: () => onTap(2),
                      ),

                      _navItem(
                        icon: 'assets/icons/profile.png',
                        label: 'Profile',
                        isActive: currentIndex == 3,
                        onTap: () => onTap(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tombol tengah (Play)
            Positioned(
              top: 30,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FocusSession()),
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.violet500,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
            color: isActive ? AppColors.violet500 : AppColors.violet300,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.violet500 : AppColors.violet300,
            ),
          ),
        ],
      ),
    );
  }
}
