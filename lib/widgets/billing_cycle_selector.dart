import 'package:flutter/material.dart';

class BillingCycleSelector extends StatelessWidget {
  final bool isYearly;
  final ValueChanged<bool> onChanged;

  const BillingCycleSelector({
    Key? key,
    required this.isYearly,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [!isYearly, isYearly],
      onPressed: (index) => onChanged(index == 1),
      color: Colors.white70,
      selectedColor: Colors.white,
      fillColor: Colors.indigo.shade600,
      borderRadius: BorderRadius.circular(12),
      constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
      children: const [
        Text('Monthly'),
        Text('Yearly (Save)'),
      ],
    );
  }
}
