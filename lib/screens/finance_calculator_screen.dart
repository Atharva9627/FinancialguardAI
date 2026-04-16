import 'package:flutter/material.dart';
import 'sip_calculator_screen.dart';
import 'mutual_fund_calculator_screen.dart';

class FinanceCalculatorScreen extends StatelessWidget {
  const FinanceCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    appBar: AppBar(
    title: const Text("Finance Calculator"),
    ),

    body: SafeArea(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    const SizedBox(height: 10),

    const Text(
    "Financial Tools",
    style: TextStyle(
    fontSize: 16,
    color: Colors.white70,
    letterSpacing: 1.1,
    ),
    ),

    const SizedBox(height: 8),

    const Text(
    "Choose a calculator",
    style: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
    ),
    ),

    const SizedBox(height: 40),

    _buildFeatureCard(
    context,
    title: "SIP Calculator",
    subtitle: "Estimate future value of monthly investments",
    icon: Icons.trending_up,
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const SIPCalculatorScreen(),
    ),
    );
    },
    ),

    const SizedBox(height: 20),

    _buildFeatureCard(
    context,
    title: "Mutual Fund Calculator",
    subtitle: "Calculate growth of lump sum investments",
    icon: Icons.account_balance,
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => const MutualFundCalculatorScreen(),
    ),
    );
    },
    ),

    ],
    ),
    ),
    ),
    );


  }

  Widget _buildFeatureCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {


    return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),

    child: Container(
    padding: const EdgeInsets.all(24),

    decoration: BoxDecoration(
    color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(20),

    border: Border.all(
    color: const Color(0xFF00B4D8).withOpacity(0.2),
    width: 1,
    ),

    boxShadow: const [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    offset: Offset(0, 5),
    ),
    ],
    ),

    child: Row(
    children: [

    Container(
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
    color: const Color(0xFF00B4D8).withOpacity(0.15),
    shape: BoxShape.circle,
    ),

    child: Icon(
    icon,
    color: const Color(0xFF00B4D8),
    size: 32,
    ),
    ),

    const SizedBox(width: 20),

    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(
    title,
    style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),

    const SizedBox(height: 6),

    Text(
    subtitle,
    style: const TextStyle(
    fontSize: 14,
    color: Colors.white60,
    ),
    ),
    ],
    ),
    ),

    const Icon(
    Icons.arrow_forward_ios,
    color: Colors.white38,
    size: 16,
    ),

    ],
    ),
    ),
    );


  }
}
