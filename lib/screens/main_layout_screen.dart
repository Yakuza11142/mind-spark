import 'package:flutter/material.dart';

// --- Imports from your actual lib/views/ directory ---
import 'home_view.dart';
import 'subjects_view.dart';
import 'rank_view.dart';
import 'rewards_view.dart';
import 'settings_view.dart';

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
          RewardsView(),
          RankView(),
          SettingsView(),
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
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Color(0xFF00FF66)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.menu_book, color: Color(0xFF00FF66)),
            label: 'Subjects',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.card_giftcard, color: Color(0xFF00FF66)),
            label: 'Rewards',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_rounded, color: Colors.white70),
            selectedIcon: Icon(Icons.star_rounded, color: Color(0xFF00FF66)),
            label: 'Rank',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.settings, color: Color(0xFF00FF66)),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
