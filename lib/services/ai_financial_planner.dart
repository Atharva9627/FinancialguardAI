import 'dart:convert';
import 'package:http/http.dart' as http;

class AIFinancialPlanner {

  static const String apiKey = "AIzaSyBqS9tbFaMyPuKUheDGMESDJU5RMnDbpG0";

  static Future<Map<String, dynamic>> generatePlan({
    required double income,
    required double expenses,
    required double savings,
    required String risk,
  }) async {

    double investable = savings * 0.80;

    double marketStrength = await fetchMarketStrength();

    Map<String, double> weights = allocationWeights(risk, marketStrength);

    Map<String, double> allocation = {};

    weights.forEach((asset, weight) {
    allocation[asset] = investable * weight;
    });

    return {
    "investable": investable,
    "allocation": allocation,
    "marketStrength": marketStrength
    };

  }

  static Future<double> fetchMarketStrength() async {

    try {

    final response = await http.get(
    Uri.parse(
    "https://api.twelvedata.com/time_series?symbol=NIFTY&interval=1day&apikey=$apiKey"
    ),
    );

    final data = jsonDecode(response.body);

    double today = double.parse(data["values"][0]["close"]);
    double yesterday = double.parse(data["values"][1]["close"]);

    double change = (today - yesterday) / yesterday;

    if (change > 0.01) return 0.65;
    if (change < -0.01) return 0.45;

    return 0.55;

    } catch (e) {

    return 0.50;

    }

  }

  static Map<String, double> allocationWeights(
      String risk,
      double marketStrength) {

    if (risk == "High Risk") {

    return {
    "Stocks": 0.35 * marketStrength,
    "Mutual Funds": 0.20,
    "ETF": 0.10,
    "Crypto": 0.15,
    "Gold": 0.08,
    "Bonds": 0.07,
    "REIT": 0.05
    };

    } else if (risk == "Moderate Risk") {

    return {
    "Stocks": 0.25 * marketStrength,
    "Mutual Funds": 0.25,
    "ETF": 0.15,
    "Crypto": 0.08,
    "Gold": 0.12,
    "Bonds": 0.10,
    "REIT": 0.05
    };

    } else {

    return {
    "Stocks": 0.15 * marketStrength,
    "Mutual Funds": 0.30,
    "ETF": 0.15,
    "Crypto": 0.03,
    "Gold": 0.17,
    "Bonds": 0.15,
    "REIT": 0.05
    };

    }

  }
}
