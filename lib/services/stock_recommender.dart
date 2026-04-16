import 'dart:convert';
import 'package:http/http.dart' as http;

class StockRecommender {

  static const String apiKey = "AIzaSyBqS9tbFaMyPuKUheDGMESDJU5RMnDbpG0";

  static const List<String> candidateStocks = [
    "RELIANCE.BSE",
    "TCS.BSE",
    "INFY.BSE",
    "HDFCBANK.BSE",
    "ICICIBANK.BSE",
    "LT.BSE",
    "ITC.BSE"
  ];

  static Future<List<Map<String, dynamic>>> getTopStocks() async {


    List<Map<String, dynamic>> results = [];

    for (String symbol in candidateStocks) {

    try {

    final priceResponse = await http.get(
    Uri.parse(
    "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey"
    ),
    );

    final priceData = jsonDecode(priceResponse.body);

    if (priceData["Global Quote"] == null ||
    priceData["Global Quote"].isEmpty) {
    continue;
    }

    var quote = priceData["Global Quote"];

    double price = double.parse(quote["05. price"]);

    double changePercent = double.parse(
    quote["10. change percent"].replaceAll("%", "")
    );

    String trend;

    if (changePercent > 1) {
    trend = "Bullish";
    } else if (changePercent < -1) {
    trend = "Bearish";
    } else {
    trend = "Stable";
    }

    final chartResponse = await http.get(
    Uri.parse(
    "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey"
    ),
    );

    final chartData = jsonDecode(chartResponse.body);

    List<double> prices = [];

    if (chartData["Time Series (Daily)"] != null) {

    var values = chartData["Time Series (Daily)"];

    int count = 0;

    values.forEach((date, data) {

    if (count < 7) {

    double closePrice =
    double.parse(data["4. close"]);

    prices.add(closePrice);

    count++;

    }

    });

    }

    prices = prices.reversed.toList();

    String cleanSymbol = symbol.replaceAll(".BSE", "");

    String reason = generateReason(cleanSymbol);

    results.add({
    "symbol": cleanSymbol,
    "price": price,
    "change": changePercent,
    "trend": trend,
    "chart": prices,
    "reason": reason
    });

    } catch (e) {

    print("Failed to fetch $symbol");

    }

    }

    results.sort((a, b) =>
    b["change"].compareTo(a["change"]));

    return results.take(3).toList();


  }

  static String generateReason(String symbol) {


    if (symbol == "RELIANCE") {
    return "Reliance Industries dominates telecom, energy, and retail sectors with strong long-term growth potential.";
    }

    if (symbol == "TCS") {
    return "Tata Consultancy Services is India's largest IT services exporter with stable global enterprise contracts.";
    }

    if (symbol == "INFY") {
    return "Infosys benefits from global digital transformation demand and strong consulting capabilities.";
    }

    if (symbol == "HDFCBANK") {
    return "HDFC Bank is India's leading private bank with strong retail lending and financial stability.";
    }

    if (symbol == "ICICIBANK") {
    return "ICICI Bank continues expanding its retail banking portfolio with improving asset quality.";
    }

    if (symbol == "LT") {
    return "Larsen & Toubro leads India's infrastructure and engineering projects with long-term growth pipeline.";
    }

    if (symbol == "ITC") {
    return "ITC has strong cash flows from FMCG, agriculture, and hotel businesses.";

    }

    return "Leading Indian blue-chip company with strong market presence.";


  }
}
