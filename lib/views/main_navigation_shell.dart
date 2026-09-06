import 'package:flutter/material.dart';
import '../services/app_repository.dart';
import 'home_view.dart';
import 'subjects_view.dart';
import 'rank_view.dart';
import 'rewards_view.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  final AppRepository _repository = AppRepository();
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAppConfig();
  }

  Future<void> _loadAppConfig() async {
    await _repository.initialize(context);
    setState(() {
      _isLoading = false;
    });
  }

  Widget _getCurrentTab(int index) {
    switch (index) {
      case 0: return HomeView();
      case 1: return SubjectsView();
      case 2: return RankView();
      case 3: return RewardsView(onStateMutation: () => setState(() {}));
      default: return HomeView();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    return Scaffold(
      body: _getCurrentTab(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: _repository.tabs.map((tab) => BottomNavigationBarItem(
          icon: Icon(tab.icon),
          label: tab.label,
        )).toList(),
      ),
    );
  }
}
