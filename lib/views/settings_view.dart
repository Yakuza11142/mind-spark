import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Settings & Profile'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Account & Support'),
          _buildSettingsTile(Icons.email, 'Support Email', 'mindsparkelite6@gmail.com'),
          _buildSettingsTile(Icons.security, 'Parental Guard & Filters', 'Active'),
          const SizedBox(height: 24),
          _buildSectionHeader('System Information'),
          _buildSettingsTile(Icons.info, 'App Version', '3.0.0 Master Build'),
          _buildSettingsTile(Icons.offline_bolt, 'Offline Mode', 'Fully Enabled'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(title, style: const TextStyle(color: Colors.indigoAccent, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      ),
    );
  }
}
