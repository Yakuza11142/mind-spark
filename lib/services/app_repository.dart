import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/app_models.dart';

extension AppIconParser on String {
  IconData get toIconData {
    switch (this.toLowerCase().trim()) {
      case 'dashboard': return Icons.dashboard_rounded;
      case 'education': return Icons.school_rounded;
      case 'trophy': return Icons.military_tech_rounded;
      case 'gift': return Icons.card_giftcard_rounded;
      case 'ai': return Icons.psychology_alt_rounded;
      case 'ar': return Icons.viewin_ar_rounded;
      case 'game': return Icons.sports_esports_rounded;
      case 'refresh': return Icons.sync_rounded;
      case 'energy': return Icons.bolt_rounded;
      case 'compass': return Icons.explore_rounded;
      case 'award': return Icons.workspace_premium_rounded;
      case 'shield': return Icons.verified_user_rounded;
      default: return Icons.widgets_rounded;
    }
  }
}

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() => _instance;
  AppRepository._internal();

  bool _isInitialized = false;
  
  List<TabItem> tabs = [];
  List<DashboardModule> modules = [];
  List<SubjectItem> subjects = [];
  List<RankItem> ranks = [];
  
  String currentRank = '';
  int sparkPoints = 0;
  bool dynamicPrizeClaimed = false;

  Future<void> initialize(BuildContext context) async {
    if (_isInitialized) return;

    final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/data/app_config.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    tabs = (jsonMap['navigationTabs'] as List).map((t) => TabItem(
      label: t['label'],
      icon: (t['icon'] as String).toIconData,
      route: t['route'],
    )).toList();

    modules = (jsonMap['homeModules'] as List? ?? []).map((m) => DashboardModule(
      title: m['title'],
      icon: (m['icon'] as String).toIconData,
      color: Color(int.parse(m['color'])),
      route: m['route'],
    )).toList();

    subjects = (jsonMap['curriculumSubjects'] as List).map((s) => SubjectItem(
      name: s['name'],
      description: s['desc'],
      route: s['route'],
    )).toList();

    if (jsonMap['ranks'] != null) {
      ranks = (jsonMap['ranks'] as List).map((r) => RankItem(
        rank: r['rank'],
        title: r['title'],
        minPoints: r['minPoints'],
        badge: (r['badge'] as String).toIconData,
      )).toList();
    }

    if (ranks.isNotEmpty) {
      currentRank = ranks.first.title;
    }

    _isInitialized = true;
  }

  bool executeDailyClaim() {
    if (!dynamicPrizeClaimed) {
      sparkPoints += 50;
      dynamicPrizeClaimed = true;
      _updateRankBasedOnPoints();
      return true;
    }
    return false;
  }

  void _updateRankBasedOnPoints() {
    for (var r in ranks) {
      if (sparkPoints >= r.minPoints) {
        currentRank = r.title;
      }
    }
  }
}
