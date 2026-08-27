import 'package:flutter/material.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool isNigeriaSelected = true;

  @override
  Widget build(BuildContext context) {
    final currencySymbol = isNigeriaSelected ? '₦' : '\$';
    final individualMo = isNigeriaSelected ? '4,500' : '9.99';
    final individualAn = isNigeriaSelected ? '39,900' : '99.99';
    final familyMo = isNigeriaSelected ? '7,500' : '14.99';
    final familyAn = isNigeriaSelected ? '74,900' : '149.99';

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Mind Spark Subscribtion Plans'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Global (USD)', style: TextStyle(color: Colors.white70)),
              Switch(
                value: isNigeriaSelected,
                activeColor: Colors.indigo,
                onChanged: (val) => setState(() => isNigeriaSelected = val),
              ),
              const Text('Nigeria (NGN)', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 16),
          _buildPricingCard('Individual Monthly', '$currencySymbol$individualMo', 'Standard access'),
          _buildPricingCard('Individual Annual', '$currencySymbol$individualAn', 'Best value (~3 months free)'),
          _buildPricingCard('Family Monthly', '$currencySymbol$familyMo', 'Up to 6 household members'),
          _buildPricingCard('Family Annual', '$currencySymbol$familyAn', 'Ultimate household retention'),
        ],
      ),
    );
  }

  Widget _buildPricingCard(String title, String price, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(color: Colors.indigoAccent, fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }
}
