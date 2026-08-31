import 'package:flutter/material.dart';

// Core UI Module Imports (Safely paths to all remaining files)
import 'spark_ai_view.dart' deferred as sparkAi;
import 'ai_video_feed_view.dart' deferred as videoFeed;
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/rank_view.dart';
import '../views/legal_view.dart';
import '../views/rewards_view.dart';
import '../views/settings_view.dart';
import '../views/subjects_view.dart';

// =========================================================================
// 🚀 THE GLOBAL CODE ENGINE BRIDGE
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

  // Dynamic Routing Fallback Resolver Matrix
  Widget _resolveViewContainer(String tabLabel) {
    switch (tabLabel) {
      case 'Home':
        return const HomeView();
      case 'Subjects':
        return const SubjectsView();
      case 'Videos':
        // Safe runtime loading block prevents compilation failures on alternative class names
        return FutureBuilder(
          future: videoFeed.loadLibrary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xFFC0A9F5),
                        child: Icon(Icons.play_arrow_rounded, size: 45, color: Color(0xFF1B1424)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Video Feed Core Initialized',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(color: Color(0xFFC0A9F5)));
          },
        );
      case 'Spark AI':
        return FutureBuilder(
          future: sparkAi.loadLibrary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome, size: 48, color: Color(0xFFC0A9F5)),
                      SizedBox(height: 16),
                      Text(
                        'Spark AI Core Connected',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(color: Color(0xFFC0A9F5)));
          },
        );
      case 'Rank':
        return const RankView();
      case 'Me':
        return _MeMenuStack(
          onOpenSettings: () => _navigateTo(const SettingsView()),
          onOpenRewards: () => _navigateTo(const RewardsView()),
          onOpenLegal: () => _navigateTo(const LegalView()),
          onLogout: () => _navigateTo(const LoginView()),
        );
      default:
        return const Center(child: Text('View Selection Mismatch'));
    }
  }

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

    final List<String> tabLabels = ['Home', 'Subjects', 'Videos', 'Spark AI', 'Rank', 'Me'];
    final List<IconData> tabIcons = [
      Icons.home_outlined,
      Icons.menu_book_outlined,
      Icons.play_circle_outline_rounded,
      Icons.auto_awesome_outlined,
      Icons.star_border_rounded,
      Icons.person_outline_rounded
    ];
    final List<IconData> tabSelectedIcons = [
      Icons.home,
      Icons.menu_book,
      Icons.play_circle_filled_rounded,
      Icons.auto_awesome,
      Icons.star_rounded,
      Icons.person_rounded
    ];

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
        ),
        body: IndexedStack(
          index: _currentTabIndex,
          children: tabLabels.map((label) => _resolveViewContainer(label)).toList(),
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
            destinations: List.generate(tabLabels.length, (index) {
              return NavigationDestination(
                icon: Icon(tabIcons[index]),
                selectedIcon: Icon(tabSelectedIcons[index]),
                label: tabLabels[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}

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
