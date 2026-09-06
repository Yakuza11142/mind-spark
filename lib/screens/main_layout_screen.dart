import 'package:flutter/material.dart';

// --- Secondary Directory View Imports ---
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
        children: [
          const HomeView(),
          const SubjectsView(),
          Builder(
            builder: (_) => const Scaffold(
              backgroundColor: themePrimaryBg,
              body: Center(
                child: Text(
                  'Search Tab',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Builder(
            builder: (_) => const Scaffold(
              backgroundColor: themePrimaryBg,
              body: Center(
                child: Text(
                  'AI Video Tab',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Builder(
            builder: (_) => const Scaffold(
              backgroundColor: themePrimaryBg,
              body: Center(
                child: Text(
                  'Spark AI Tab',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          const RankView(),
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
            icon: Icon(Icons.search_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.search, color: Color(0xFF00FF66)),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.play_circle_filled, color: Color(0xFF00FF66)),
            label: 'AI Video',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.auto_awesome, color: Color(0xFF00FF66)),
            label: 'Spark AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_rounded, color: Colors.white70),
            selectedIcon: Icon(Icons.star_rounded, color: Color(0xFF00FF66)),
            label: 'Rank',
          ),
        ],
      ),
    );
  }
}
