import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final IconData icon;
  final String route;
  const TabItem({required this.label, required this.icon, required this.route});
}

class DashboardModule {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  const DashboardModule({required this.title, required this.icon, required this.color, required this.route});
}

class SubjectItem {
  final String name;
  final String description;
  final String route;
  const SubjectItem({required this.name, required this.description, required this.route});
}
