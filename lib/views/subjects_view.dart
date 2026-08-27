import 'package:flutter/material.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> subjects = [
      {'name': 'Mathematics', 'desc': 'Algebra, Geometry & Spatial Vectors'},
      {'name': 'English Language', 'desc': 'Grammar, Reading & Comprehension'},
      {'name': 'Basic Science', 'desc': 'Physics, Chemistry & Biology'},
      {'name': 'Information Technology', 'desc': 'Coding, Algorithms & Logic'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Curriculum Subjects'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subj = subjects[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.withOpacity(0.3)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(subj['name'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(subj['desc'] ?? '', style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.indigoAccent, size: 16),
              onTap: () {
                // Navigate to subject chapters & levels
              },
            ),
          );
        },
      ),
    );
  }
}
