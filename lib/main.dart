import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FinancialGuardApp());
}

class FinancialGuardApp extends StatelessWidget {
  const FinancialGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinancialGuard AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // Deep background color matching the outer edges of your logo
        scaffoldBackgroundColor: const Color(0xFF061428),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00B4D8), // The bright teal/cyan for highlights
          secondary: Color(0xFF0A2A4A), // The core navy blue
          surface: Color(0xFF0F2540), // A slightly lighter blue for cards
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),

        // Globally styling the AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF00B4D8)),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),

        // The corrected CardThemeData block
        cardTheme: const CardThemeData(
          color: Color(0xFF0F2540),
          elevation: 8.0,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),

        // Globally styling main buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00B4D8),
            foregroundColor: Colors.white,
            elevation: 4.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}