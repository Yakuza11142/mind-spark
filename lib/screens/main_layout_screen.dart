import 'package:flutter/material.dart';

// Core Framework Imports
import 'spark_ai_view.dart';
import 'ai_video_feed_view.dart';
import '../views/home_view.dart';
import '../views/rank_view.dart';
import '../views/subjects_view.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color themePrimaryBg = Color(0xFF1B1424);
    const Color themeNavBarBg = Color(0xFF130E1B);

    return Scaffold(
      backgroundColor: themePrimaryBg,
      body: IndexedStack(
        index: _activeTabIndex,
        children: const [
          HomeView(),
          SubjectsView(),
          AiVideoFeedView(),
          SparkAiView(),
          RankView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeTabIndex,
        backgroundColor: themeNavBarBg,
        elevation: 0,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (index) => setState(() => _activeTabIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: Color(0xFF00FF66)), label: ''),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book, color: Color(0xFF00FF66)), label: ''),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), selectedIcon: Icon(Icons.play_circle_filled, color: Color(0xFF00FF66)), label: ''),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome, color: Color(0xFF00FF66)), label: ''),
          NavigationDestination(icon: Icon(Icons.star_border_rounded), selectedIcon: Icon(Icons.star_rounded, color: Color(0xFF00FF66)), label: ''),
        ],
      ),
    );
  }
}
