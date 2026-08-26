import 'package:flutter/material.dart';

class StudyRecommendationCard extends StatelessWidget {
  final String title;
  final String subject;
  final VoidCallback onTap;

  const StudyRecommendationCard({
    Key? key,
    required this.title,
    required this.subject,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.withOpacity(0.4)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.auto_awesome_rounded, color: Colors.purpleAccent),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Recommended for $subject',
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 14),
        onTap: onTap,
      ),
    );
  }
}
