import 'dart:math';

class FinancialAI {

  static double futureValue(
      double monthlyInvestment,
      double annualReturn,
      int years) {

    double monthlyRate = annualReturn / 12;
    int months = years * 12;

    double fv =
    monthlyInvestment * ((pow(1 + monthlyRate, months) - 1) / monthlyRate);

    return fv;

  }

  static List<double> generateWealthTimeline(
      double monthlyInvestment,
      double annualReturn,
      int years,
      ) {
    double total = 0;
    double monthlyRate = annualReturn / 12;

    List<double> timeline = [];

    for (int y = 1; y <= years; y++) {

      for (int m = 0; m < 12; m++) {
        total = (total + monthlyInvestment) * (1 + monthlyRate);
      }

      timeline.add(total);
    }

    return timeline;
  }

  static Map<String, dynamic> analyze({
    required double income,
    required double expenses,
    required double investments,
    required int years,
  }) {


    double savings = income - expenses;

    if (savings < 0) savings = 0;

    double savingsRate = income == 0 ? 0 : savings / income;


    double riskScore = 50;

    if (savingsRate < 0.15) riskScore += 25;
    if (expenses > income * 0.75) riskScore += 15;
    if (investments > savings * 2) riskScore -= 10;

    riskScore = riskScore.clamp(0, 100);

    String risk;

    if (riskScore > 70) {
    risk = "High Risk";
    } else if (riskScore > 40) {
    risk = "Moderate Risk";
    } else {
    risk = "Low Risk";
    }


    double confidence = 70;

    if (savingsRate > 0.30) confidence += 10;
    if (investments > savings) confidence += 10;

    confidence = confidence.clamp(0, 100);


    double investable = savings * 0.70;

    List<double> wealthTimeline =
        generateWealthTimeline(investable, 0.10, years);


    double stocks;
    double mutualFunds;
    double etf;
    double gold;
    double crypto;

    if (risk == "High Risk") {

    stocks = investable * 0.40;
    mutualFunds = investable * 0.25;
    etf = investable * 0.15;
    crypto = investable * 0.15;
    gold = investable * 0.05;

    } else if (risk == "Moderate Risk") {

    stocks = investable * 0.30;
    mutualFunds = investable * 0.35;
    etf = investable * 0.20;
    gold = investable * 0.10;
    crypto = investable * 0.05;

    } else {

    stocks = investable * 0.20;
    mutualFunds = investable * 0.40;
    etf = investable * 0.20;
    gold = investable * 0.15;
    crypto = investable * 0.05;

    }


    double stocksFuture = futureValue(stocks, 0.12, years);
    double mfFuture = futureValue(mutualFunds, 0.10, years);
    double etfFuture = futureValue(etf, 0.09, years);
    double goldFuture = futureValue(gold, 0.06, years);
    double cryptoFuture = futureValue(crypto, 0.15, years);

    double projectedWealth =
    stocksFuture + mfFuture + etfFuture + goldFuture + cryptoFuture;


    List<String> insights = [
    "Income and expense structure evaluated.",
    "Savings discipline assessed for long term stability.",
    "Portfolio diversification model generated.",
    "Risk exposure calculated using financial behaviour indicators."
    ];


    List<String> recommendations = [
    "Maintain a savings rate above 30 percent of income.",
    "Ensure emergency reserves cover at least six months of expenses.",
    "Diversify investments across equity, index funds and stable assets.",
    "Automate monthly investments to maintain long term discipline."
    ];


    List<String> investmentPlan = [

    "Invest ${stocks.toStringAsFixed(0)} Rupees per month in diversified stocks or equity funds.",

    "Invest ${mutualFunds.toStringAsFixed(0)} Rupees per month in mutual funds for balanced growth.",

    "Invest ${etf.toStringAsFixed(0)} Rupees per month in index ETFs for stable market tracking.",

    "Allocate ${gold.toStringAsFixed(0)} Rupees per month to gold or defensive assets.",

    "Allocate ${crypto.toStringAsFixed(0)} Rupees per month to high growth speculative assets."

    ];


    return {

      "wealthTimeline": wealthTimeline,
    "income": income,
    "expenses": expenses,
    "savings": savings,

    "projection": projectedWealth,

    "riskScore": riskScore,
    "risk": risk,
    "confidence": confidence,

    "stocksFuture": stocksFuture,
    "mfFuture": mfFuture,
    "etfFuture": etfFuture,
    "goldFuture": goldFuture,
    "cryptoFuture": cryptoFuture,

    "insights": insights,
    "recommendations": recommendations,
    "investmentPlan": investmentPlan


    };

  }
}
