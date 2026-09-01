import 'package:flutter/material.dart';

// Core Framework Imports
import 'spark_ai_view.dart';
import 'ai_video_feed_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/rank_view.dart';
import '../views/legal_view.dart';
import '../views/rewards_view.dart';
import '../views/settings_view.dart';
import '../views/subjects_view.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _activeTabIndex = 0;

  // Streamlined Navigation Tab Matrix mapping structural icons cleanly
  late final List<_TabToken> _navigationTabs = [
    const _TabToken(Icons.home_outlined, Icons.home),
    const _TabToken(Icons.menu_book_outlined, Icons.menu_book),
    const _TabToken(Icons.play_circle_outline, Icons.play_circle_filled),
    const _TabToken(Icons.auto_awesome_outlined, Icons.auto_awesome),
    const _TabToken(Icons.star_border_rounded, Icons.star_rounded),
  ];

  // ✅ FIXED: Routes side views cleanly using direct string identifiers matching lib/main.dart
  void _routeToIsolatedView(String pathString) {
    Navigator.pushNamed(context, pathString);
  }

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
      drawer: Drawer(
        backgroundColor: themePrimaryBg,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFF382944),
              child: Icon(Icons.person, size: 36, color: Color(0xFF00FF66)),
            ),
            const SizedBox(height: 32),
            // ✅ FIXED: String-based navigation endpoints
            _buildDrawerTile(Icons.card_membership, () => _routeToIsolatedView('/rewards_view')),
            _buildDrawerTile(Icons.settings, () => _routeToIsolatedView('/settings_view')),
            _buildDrawerTile(Icons.gavel, () => _routeToIsolatedView('/legal_view')),
            const Divider(color: Colors.white10, height: 40),
            _buildDrawerTile(Icons.logout, () => _routeToIsolatedView('/login'), isAlert: true),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: const NavigationBarThemeData(
            indicatorColor: Color(0xFF382944),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _activeTabIndex,
          backgroundColor: themeNavBarBg,
          elevation: 0,
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (index) => setState(() => _activeTabIndex = index),
          destinations: _navigationTabs.map((tab) {
            return NavigationDestination(
              icon: Icon(tab.defaultIcon, color: Colors.white60),
              selectedIcon: Icon(tab.activeIcon, color: const Color(0xFF00FF66)),
              label: '',
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, VoidCallback onTap, {bool isAlert = false}) {
    return ListTile(
      leading: Icon(icon, color: isAlert ? Colors.redAccent : const Color(0xFF00FF66)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
      onTap: () {
        Navigator.pop(context); // Closes drawer safely
        onTap();
      },
    );
  }
}

class _TabToken {
  final IconData defaultIcon;
  final IconData activeIcon;
  const _TabToken(this.defaultIcon, this.activeIcon);
}
