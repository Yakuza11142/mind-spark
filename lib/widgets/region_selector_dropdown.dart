import 'package:flutter/material.dart';

class RegionSelectorDropdown extends StatelessWidget {
  final String selectedRegion;
  final ValueChanged<String?> onRegionChanged;

  const RegionSelectorDropdown({
    Key? key,
    required this.selectedRegion,
    required this.onRegionChanged,
  }) : super(key: key);

  final List<String> _regions = const ['Global (Default)', 'Africa (NGN/USD)', 'North America', 'Europe', 'Asia-Pacific'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRegion,
          dropdownColor: const Color(0xFF0F172A),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
          items: _regions.map((String region) {
            return DropdownMenuItem<String>(
              value: region,
              child: Text(region, style: const TextStyle(color: Colors.white, fontSize: 13)),
            );
          }).toList(),
          onChanged: onRegionChanged,
        ),
      ),
    );
  }
}
