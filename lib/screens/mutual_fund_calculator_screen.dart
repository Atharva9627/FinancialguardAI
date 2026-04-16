import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class MutualFundCalculatorScreen extends StatefulWidget {
  const MutualFundCalculatorScreen({super.key});

  @override
  State<MutualFundCalculatorScreen> createState() =>
      _MutualFundCalculatorScreenState();
}

class _MutualFundCalculatorScreenState
    extends State<MutualFundCalculatorScreen> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();

  final NumberFormat formatter = NumberFormat('#,##,###');

  double futureValue = 0;
  List<FlSpot> chart = [];

  void calculate() {


    double principal = double.parse(amountController.text);
    double rate = double.parse(rateController.text) / 100;
    int years = int.parse(yearsController.text);

    double fv = principal * pow(1 + rate, years);

    List<FlSpot> spots = [];

    for(int i = 1; i <= years; i++){
    double value = principal * pow(1 + rate, i);
    spots.add(FlSpot(i.toDouble(), value));
    }

    setState(() {
    futureValue = fv;
    chart = spots;
    });


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
    appBar: AppBar(
    title: const Text("Mutual Fund Calculator"),
    ),

    body: SafeArea(
    child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    const Text(
    "Investment Planner",
    style: TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),

    const SizedBox(height: 8),

    const Text(
    "Calculate the growth of your lump sum investment",
    style: TextStyle(
    color: Colors.white70,
    ),
    ),

    const SizedBox(height: 30),

    Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
    color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(20),

    border: Border.all(
    color: const Color(0xFF00B4D8).withOpacity(0.2),
    ),
    ),

    child: Column(
    children: [

    TextField(
    controller: amountController,
    keyboardType: TextInputType.number,

    decoration: const InputDecoration(
    labelText: "Investment Amount (₹)",
    ),
    ),

    const SizedBox(height: 15),

    TextField(
    controller: rateController,
    keyboardType: TextInputType.number,

    decoration: const InputDecoration(
    labelText: "Expected Return (%)",
    ),
    ),

    const SizedBox(height: 15),

    TextField(
    controller: yearsController,
    keyboardType: TextInputType.number,

    decoration: const InputDecoration(
    labelText: "Investment Period (Years)",
    ),
    ),

    const SizedBox(height: 25),

    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: calculate,
    child: const Text("Calculate Investment"),
    ),
    )

    ],
    ),
    ),

    const SizedBox(height: 30),

    if(futureValue > 0)
    Container(
    width: double.infinity,
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

    const Text(
    "Estimated Future Value",
    style: TextStyle(
    color: Colors.white70,
    ),
    ),

    const SizedBox(height: 8),

    Text(
    "₹ ${formatter.format(futureValue)}",
    style: const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF00B4D8),
    ),
    ),

    ],
    ),
    ),

    const SizedBox(height: 30),

    if(chart.isNotEmpty)
    Container(
    height: 300,
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
    color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(20),

    border: Border.all(
    color: const Color(0xFF00B4D8).withOpacity(0.2),
    ),
    ),

    child: LineChart(
    LineChartData(

    gridData: FlGridData(show: true),

    titlesData: FlTitlesData(
    bottomTitles: AxisTitles(
    sideTitles: SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
    return Text(
    value.toInt().toString(),
    style: const TextStyle(
    color: Colors.white54,
    fontSize: 10,
    ),
    );
    },
    ),
    ),
    ),

    lineBarsData: [

    LineChartBarData(
    spots: chart,
    isCurved: true,
    barWidth: 4,
    color: const Color(0xFF00B4D8),
    dotData: FlDotData(show: false),
    )

    ],
    ),
    ),
    )

    ],
    ),
    ),
    ),
    );


  }
}
