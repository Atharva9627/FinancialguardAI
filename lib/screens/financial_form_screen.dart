import 'package:flutter/material.dart';
import 'result_screen.dart';

class FinancialFormScreen extends StatefulWidget {
  const FinancialFormScreen({super.key});

  @override
  State<FinancialFormScreen> createState() => _FinancialFormScreenState();
}

class _FinancialFormScreenState extends State<FinancialFormScreen> {

  final salaryController = TextEditingController();
  final otherIncomeController = TextEditingController();

  final rentController = TextEditingController();
  final groceryController = TextEditingController();
  final electricityController = TextEditingController();
  final transportController = TextEditingController();

  final sipController = TextEditingController();
  final stocksController = TextEditingController();
  final cryptoController = TextEditingController();

  final yearsController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    appBar: AppBar(title: const Text("Financial Profile")),

    body: SafeArea(
    child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    const Text(
    "Tell us about your finances",
    style: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),

    const SizedBox(height: 30),

    buildSectionCard(
    "Income Details",
    [
    buildField("Monthly Salary", salaryController),
    buildField("Other Income", otherIncomeController),
    ],
    ),

    const SizedBox(height: 25),

    buildSectionCard(
    "Monthly Expenses",
    [
    buildField("Rent / EMI", rentController),
    buildField("Groceries", groceryController),
    buildField("Electricity Bill", electricityController),
    buildField("Transport", transportController),
    ],
    ),

    const SizedBox(height: 25),

    buildSectionCard(
    "Investments",
    [
    buildField("Monthly SIP", sipController),
    buildField("Stocks Investment", stocksController),
    buildField("Crypto Investment", cryptoController),
    ],
    ),

    const SizedBox(height: 25),

    buildSectionCard(
    "Projection Period",
    [
    buildField("Result After How Many Years?", yearsController),
    ],
    ),

    const SizedBox(height: 30),

    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    child: const Text("Run AI Financial Analysis"),
    onPressed: () {

    double salary = double.parse(salaryController.text);
    double otherIncome = double.parse(otherIncomeController.text);

    double rent = double.parse(rentController.text);
    double groceries = double.parse(groceryController.text);
    double electricity = double.parse(electricityController.text);
    double transport = double.parse(transportController.text);

    double sip = double.parse(sipController.text);
    double stocks = double.parse(stocksController.text);
    double crypto = double.parse(cryptoController.text);

    int years = int.parse(yearsController.text);

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => ResultScreen(
    salary: salary + otherIncome,
    rent: rent + groceries + electricity + transport,
    groceries: sip + stocks + crypto,
    ),
    ),
    );
    },
    ),
    )

    ],
    ),
    ),
    ),
    );


  }

  Widget buildSectionCard(String title, List<Widget> children) {


    return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
    color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(20),

    border: Border.all(
    color: const Color(0xFF00B4D8).withOpacity(0.2),
    ),
    ),

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

    const SizedBox(height: 15),

    ...children

    ],
    ),
    );


  }

  Widget buildField(String label, TextEditingController controller) {


    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),

    child: TextField(
    controller: controller,
    keyboardType: TextInputType.number,

    style: const TextStyle(color: Colors.white),

    decoration: InputDecoration(

    labelText: label,

    labelStyle: const TextStyle(color: Colors.white70),

    filled: true,
    fillColor: const Color(0xFF061428),

    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    ),

    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white24),
    ),

    focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF00B4D8)),
    ),
    ),
    ),
    );


  }
}
