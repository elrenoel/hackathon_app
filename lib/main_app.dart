import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/deep_read_page.dart';
import 'pages/map_analitics_page.dart';
import 'pages/profile_page.dart';
import 'widgets/custom_bottom_navbar.dart';

class MainApp extends StatefulWidget {
  final int initialIndex;
  const MainApp({super.key, this.initialIndex = 0});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int _currentIndex;

  // final List<Widget> _pages = const [
  //   HomePage(),
  //   DeepReadPage(mood: 'Balanced'),
  //   MapAnaliticsPage(),
  //   ProfilePage(),
  // ];
  void switchToDeepRead() {
    setState(() {
      _currentIndex = 1; // index DeepRead
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;

    _pages = [
      HomePage(onMoodSubmitted: switchToDeepRead),
      const DeepReadPage(),
      const MapAnaliticsPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
