import 'package:flutter/material.dart';
import 'financial_wizard_screen.dart';
import 'finance_calculator_screen.dart';
import 'savaya_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "FinancialGuard AI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Welcome back, Investor!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "What are you looking for today?",
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
                title: "Start Financial Analysis",
                subtitle: "Get AI-driven insights for your portfolio",
                icon: Icons.analytics_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FinancialWizardScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),


              const SizedBox(height: 20),

              _buildFeatureCard(
                context,
                title: "Finance Calculator",
                subtitle: "Compute loans, investments, and EMI",
                icon: Icons.calculate_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FinanceCalculatorScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00B4D8),
        elevation: 6.0,
        icon: const Icon(Icons.smart_toy, color: Colors.white),
        label: const Text(
            "SAVAYA Chat",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: const Color(0xFF0F2540),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                    color: const Color(0xFF00B4D8).withOpacity(0.5),
                    width: 1.5
                ),
              ),
              child: const SizedBox(
                width: 300,
                height: 420,

                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: SavayaChatScreen(),
                ),
              ),
            ),
          );
        },
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
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2540), // Dark blue card surface
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color(0xFF00B4D8).withOpacity(0.2),
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF00B4D8).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF00B4D8), size: 32.0),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white38,
                size: 16.0
            ),
          ],
        ),
      ),
    );
  }
}
