import 'package:flutter/material.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  // 1. Tracks the active navigation index
  int _currentTabIndex = 2; // Default selected to 2 (Videos) to match your screenshot

  static const String appTitle = 'MindSpark';
  static const String welcomeMessage = 'Welcome to MindSpark!\nEngine Core Initialized Successfully.';

  // ==========================================
  // 🔍 6-TAB CONTENT ARRANGEMENT
  // ==========================================
  late final List<Widget> _tabs = [
    // Tab 0: Home
    const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          welcomeMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
        ),
      ),
    ),
    
    // Tab 1: Subjects
    const Center(
      child: Text('📚 Subjects Screen', style: TextStyle(fontSize: 16, color: Colors.white70)),
    ),
    
    // Tab 2: Videos (Matches your updated screenshot UI)
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFC0A9F5), // Light purple icon background
            child: Icon(
              Icons.play_arrow_rounded,
              size: 45,
              color: Color(0xFF1B1424), // Dark deep purple icon color
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Videos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ),
    
    // Tab 3: Spark AI
    const Center(
      child: Text('🤖 Spark AI Screen', style: TextStyle(fontSize: 16, color: Colors.white70)),
    ),

    // Tab 4: Rank
    const Center(
      child: Text('⭐ Rank Screen', style: TextStyle(fontSize: 16, color: Colors.white70)),
    ),

    // Tab 5: Me (Settings/Profile)
    const Center(
      child: Text('👤 Profile & Settings Screen', style: TextStyle(fontSize: 16, color: Colors.white70)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Custom dark deep background matching your screenshot palette
    final Color deepBackgroundColor = const Color(0xFF1B1424);
    final Color navigationBarColor = const Color(0xFF130E1B);

    return Scaffold(
      backgroundColor: deepBackgroundColor,
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
        backgroundColor: deepBackgroundColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: _tabs,
      ),
      
      // ==========================================
      // 🔍 NAVIGATION ARRANGEMENT (6 ITEMS MATCHING SCREENSHOT)
      // ==========================================
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // Styles the selection pill indicator box behind the active icon
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: const Color(0xFF382944), // Soft dark purple selected container tint
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: Color(0xFFF0E6FF)); // Bright active icon
              }
              return const IconThemeData(color: Colors.white60); // Dim inactive icon
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400);
              }
              return const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w400);
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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Subjects',
            ),
            NavigationDestination(
              icon: Icon(Icons.play_circle_outline_rounded),
              selectedIcon: Icon(Icons.play_circle_filled_rounded),
              label: 'Videos',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome),
              label: 'Spark AI',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_border_rounded),
              selectedIcon: Icon(Icons.star_rounded),
              label: 'Rank',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
