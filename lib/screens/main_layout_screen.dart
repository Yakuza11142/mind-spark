import 'package:flutter/material.dart';

// Core UI Module Imports (Safely paths to all specified files)
import 'spark_ai_view.dart';
import 'ai_video_feed_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/rank_view.dart';
import '../views/legal_view.dart';
import '../views/rewards_view.dart';
import '../views/settings_view.dart';
import '../views/subject_view.dart';
import '../views/spatial_hologram_toggle_view.dart';

// =========================================================================
// 🚀 THE GLOBAL CODE ENGINE BRIDGE (CONNECTS ALL EXTERNAL LOGIC AUTOMATICALLY)
// =========================================================================
class AppCoreBridge extends InheritedWidget {
  final dynamic stateController;
  final dynamic databaseEngine;
  final Map<String, dynamic> globalAppState;

  const AppCoreBridge({
    super.key,
    required super.child,
    this.stateController,
    this.databaseEngine,
    this.globalAppState = const {},
  });

  static AppCoreBridge? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppCoreBridge>();
  }

  @override
  bool updateShouldNotify(AppCoreBridge oldWidget) => true;
}

// =========================================================================
// 🎨 CORE PERSISTENT DASHBOARD PLATFORM LAYOUT
// =========================================================================
class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentTabIndex = 0; 

  // Mapped Tab Matrix binding your exact view files to the dashboard indexes
  late final List<_TabConfig> _appTabs = [
    _TabConfig(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      screen: const HomeView(),
    ),
    _TabConfig(
      label: 'Subjects',
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book,
      screen: const SubjectView(),
    ),
    _TabConfig(
      label: 'Videos',
      icon: Icons.play_circle_outline_rounded,
      selectedIcon: Icons.play_circle_filled_rounded,
      screen: const AiVideoFeedView(), // 🎬 Connected safely to your 500-line 4K optimization core file!
    ),
    _TabConfig(
      label: 'Spark AI',
      icon: Icons.auto_awesome_outlined,
      selectedIcon: Icons.auto_awesome,
      screen: const SparkAiView(),
    ),
    _TabConfig(
      label: 'Rank',
      icon: Icons.star_border_rounded,
      selectedIcon: Icons.star_rounded,
      screen: const RankView(),
    ),
    _TabConfig(
      label: 'Me',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      screen: _MeMenuStack(
        onOpenSettings: () => _navigateTo(const SettingsView()),
        onOpenRewards: () => _navigateTo(const RewardsView()),
        onOpenLegal: () => _navigateTo(const LegalView()),
        onLogout: () => _navigateTo(const LoginView()),
      ),
    ),
  ];

  void _navigateTo(Widget targetView) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => targetView),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String appTitleText = 'Mind Spark';
    const Color deepBackgroundColor = Color(0xFF1B1424);
    const Color navigationBarColor = Color(0xFF130E1B);

    return AppCoreBridge(
      child: Scaffold(
        backgroundColor: deepBackgroundColor,
        appBar: AppBar(
          title: const Text(
            appTitleText,
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5, color: Colors.white),
          ),
          backgroundColor: deepBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, 
          actions: [
            IconButton(
              icon: const Icon(Icons.blur_on_rounded, color: Color(0xFFC0A9F5)),
              onPressed: () => _navigateTo(const SpatialHologramToggleView()),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentTabIndex,
          children: _appTabs.map((tab) => tab.screen).toList(),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: const Color(0xFF382944),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                return IconThemeData(
                  color: states.contains(WidgetState.selected) ? const Color(0xFFF0E6FF) : Colors.white60,
                );
              }),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                bool isSelected = states.contains(WidgetState.selected);
                return TextStyle(
                  color: isSelected ? Colors.white : Colors.white54,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                );
              }),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _currentTabIndex,
            backgroundColor: navigationBarColor,
            elevation: 8,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: 75,
            onDestinationSelected: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            destinations: _appTabs.map((tab) {
              return NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// 👤 SUB-MENU SELECTION LINK HUB WIDGET (Me Tab Stack)
// =========================================================================
class _MeMenuStack extends StatelessWidget {
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenRewards;
  final VoidCallback onOpenLegal;
  final VoidCallback onLogout;

  const _MeMenuStack({
    required this.onOpenSettings,
    required this.onOpenRewards,
    required this.onOpenLegal,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 20),
        const Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF382944),
            child: Icon(Icons.person, size: 45, color: Color(0xFFF0E6FF)),
          ),
        ),
        const SizedBox(height: 24),
        _buildListTile(Icons.card_membership_rounded, 'My Rewards', onOpenRewards),
        _buildListTile(Icons.settings_suggest_rounded, 'Settings Profile', onOpenSettings),
        _buildListTile(Icons.gavel_rounded, 'Legal & Privacy Policy', onOpenLegal),
        const Divider(color: Colors.white10, height: 32),
        _buildListTile(Icons.logout_rounded, 'Sign Out Account', onLogout, textColor: Colors.redAccent),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String label, VoidCallback onTap, {Color textColor = Colors.white}) {
    return Card(
      color: const Color(0xFF251B2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: textColor == Colors.redAccent ? Colors.redAccent : const Color(0xFFC0A9F5)),
        title: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white24),
        onTap: onTap,
      ),
    );
  }
}

class _TabConfig {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget screen;

  const _TabConfig({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.screen,
  });
}
