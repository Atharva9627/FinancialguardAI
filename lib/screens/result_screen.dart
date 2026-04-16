import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../services/financial_ai.dart';
import '../services/ai_financial_advisor.dart';
import '../services/pdf_report_generator.dart';
import '../services/stock_recommender.dart';
import '../services/ai_financial_planner.dart';
import '../services/ai_asset_recommender.dart';

class ResultScreen extends StatefulWidget {

  final double salary;
  final double rent;
  final double groceries;

  const ResultScreen({
    super.key,
    required this.salary,
    required this.rent,
    required this.groceries,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  Map result = {};
  Map planner = {};
  Map aiAssets = {};

  List<Map<String,dynamic>> recommendedStocks = [];

  String aiReport = "";
  String displayedText = "AI analyzing financial profile...\n\n";

  bool loading = true;

  @override
  void initState() {
    super.initState();
    runAnalysis();
  }

  Future<void> runAnalysis() async {


    result = FinancialAI.analyze(
    income: widget.salary,
    expenses: widget.rent,
    investments: widget.groceries,
    years: 10,
    );

    aiReport = await AIFinancialAdvisor.generateAdvice(
    income: result["income"],
    expenses: result["expenses"],
    savings: result["savings"],
    projection: result["projection"],
    risk: result["risk"],
    );

    final assets = await AIAssetRecommender.generateAssets(
    income: result["income"],
    savings: result["savings"],
    risk: result["risk"],
    );

    aiAssets = assets;

    planner = await AIFinancialPlanner.generatePlan(
    income: result["income"],
    expenses: result["expenses"],
    savings: result["savings"],
    risk: result["risk"],
    );

    recommendedStocks = await StockRecommender.getTopStocks();

    showLiveReport(aiReport);

    setState(() {
    loading = false;
    });


  }

  void showLiveReport(String text) async {
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 15));
      setState(() {
        displayedText += text[i];
      });
    }
  }

  Widget buildAssetCards(List<dynamic> assetsList){


    if(assetsList.isEmpty){
    return const Text(
    "AI is analyzing opportunities...",
    style: TextStyle(color: Colors.white70),
    );
    }

    return Row(
    children: assetsList.map<Widget>((asset){

    return Expanded(
    child: Container(
    margin: const EdgeInsets.symmetric(horizontal:8,vertical:8),
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF00B4D8).withOpacity(0.2),
        )  ),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(
    asset["name"] ?? "",
    style: const TextStyle(
    fontSize:18,
    fontWeight:FontWeight.bold,
    color: Colors.white,
    ),
    ),

    const SizedBox(height:6),

    if(asset["symbol"]!=null)
    Text(
    "Symbol: ${asset["symbol"]}",
    style: const TextStyle(color: Colors.greenAccent),
    ),

    const SizedBox(height:8),

    Text(
    asset["reason"] ?? "",
    style: const TextStyle(
    fontSize:13,
    color: Colors.white70,
    ),
    )

    ],
    ),
    ),
    );

    }).toList(),
    );


  }

  @override
  Widget build(BuildContext context) {


    List timeline = result["wealthTimeline"] ?? [];

    return Scaffold(
    appBar: AppBar(
    title: const Text("FinancialGuard AI Report"),
    ),

    body: loading
    ? const Center(child: CircularProgressIndicator())
        : Padding(
    padding: const EdgeInsets.all(20),

    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text(
        "Financial Summary",
        style: TextStyle(fontSize:22,fontWeight:FontWeight.bold),
      ),

      const SizedBox(height:15),

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Monthly Income: ${result["income"]?.toStringAsFixed(0)} Rupees",
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height:6),

            Text(
              "Monthly Expenses: ${result["expenses"]?.toStringAsFixed(0)} Rupees",
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height:6),

            Text(
              "Monthly Savings: ${result["savings"]?.toStringAsFixed(0)} Rupees",
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height:12),

            Text(
              "Risk Level: ${result["risk"] ?? ""}",
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height:12),

            Text(
              "Projected Wealth: ${result["projection"]?.toStringAsFixed(0)} Rupees",
              style: const TextStyle(
                color: Color(0xFF00B4D8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

          ],
        ),
      ),

    const SizedBox(height:30),

    const Text(
    "Projected Wealth Growth",
    style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),
    ),

    const SizedBox(height:15),

    if(timeline.isNotEmpty)
    SizedBox(
    height:250,
    child: LineChart(
    LineChartData(
    lineBarsData:[
    LineChartBarData(
    spots: List.generate(
    timeline.length,
    (i)=>FlSpot(i.toDouble(),timeline[i].toDouble()),
    ),
    isCurved:true,
    barWidth:4,
    dotData:FlDotData(show:false),
    )
    ],
    ),
    ),
    ),

    const SizedBox(height:40),

    const Text(
    "AI Financial Advisor",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold),
    ),

    const SizedBox(height:10),

      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F2540),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF00B4D8).withOpacity(0.2),
          ),
        ),
        child: Text(
          displayedText,
          style: const TextStyle(color: Colors.white),
        ),
      ),

    const SizedBox(height:40),

    const Text(
    "AI Financial Planner",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold),
    ),

    const SizedBox(height:20),

    if(planner.isNotEmpty)
    Column(
    children: (planner["allocation"] as Map? ?? {})
        .entries
        .map<Widget>((entry){

    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
    Text(entry.key),
    Text("${entry.value.toStringAsFixed(0)} Rupees")
    ],
    );

    }).toList(),
    ),

    const SizedBox(height:40),

    const Text("STOCKS",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    const SizedBox(height:10),

    recommendedStocks.isEmpty
    ? const Text("Loading stock recommendations...")
        : Row(
    children: recommendedStocks.map((stock){

    return Expanded(
    child: Container(
    margin: const EdgeInsets.symmetric(horizontal:8),
    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: const Color(0xFF0F2540),
    borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: const Color(0xFF00B4D8).withOpacity(0.2),
      )  ),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
    Text(stock["symbol"]),
    Text("Price: ${stock["price"]} Rupees"),
    const SizedBox(height:6),
    Text(stock["reason"]),
    ],
    ),
    ),
    );

    }).toList(),
    ),

    const SizedBox(height:40),

    const Text("MUTUAL FUNDS",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    buildAssetCards(aiAssets["mutualFunds"] ?? []),

    const SizedBox(height:40),

    const Text("ETFs",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    buildAssetCards(aiAssets["etfs"] ?? []),

    const SizedBox(height:40),

    const Text("CRYPTO",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    buildAssetCards(aiAssets["crypto"] ?? []),

    const SizedBox(height:40),

    const Text("GOLD",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    buildAssetCards(aiAssets["gold"] ?? []),

    const SizedBox(height:40),

    const Text("REITs",
    style: TextStyle(fontSize:22,fontWeight:FontWeight.bold)),

    buildAssetCards(aiAssets["reits"] ?? []),

    const SizedBox(height:40),

    ElevatedButton(
    onPressed: () async {

    String path =
    await PDFReportGenerator.generateReport(
    income: result["income"],
    expenses: result["expenses"],
    savings: result["savings"],
    projection: result["projection"],
    risk: result["risk"],
    aiReport: aiReport,
    );

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("PDF generated at: $path")),
    );

    },
    child: const Text("Download AI Report"),
    )

    ],
    ),
    ),
    ),
    );


  }
}
