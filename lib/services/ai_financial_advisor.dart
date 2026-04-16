import 'dart:convert';
import 'package:http/http.dart' as http;

class AIFinancialAdvisor {

  static const String apiKey = "AIzaSyBqS9tbFaMyPuKUheDGMESDJU5RMnDbpG0";

  static Future<String> generateAdvice({
    required double income,
    required double expenses,
    required double savings,
    required double projection,
    required String risk,
  }) async {

    String prompt = """
```

You are a professional financial advisor system.

Analyze the following financial data and produce a concise financial report.

Income: $income Rupees
Expenses: $expenses Rupees
Savings: $savings Rupees
Projected Wealth: $projection Rupees
Risk Level: $risk

Generate a structured financial analysis in maximum 12 to 15 lines.

Sections required:
Financial Health Summary
Risk Analysis
Investment Recommendations
Expense Optimization
Long-Term Strategy

Do NOT use markdown symbols like *, #, or bullet formatting.
Write the report like a professional financial system.
""";

    try {

    final response = await http.post(
    Uri.parse(
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey"
    ),
    headers: {
    "Content-Type": "application/json",
    },
    body: jsonEncode({
    "contents": [
    {
    "parts": [
    {"text": prompt}
    ]
    }
    ]
    }),
    );

    print("Gemini Status: ${response.statusCode}");
    print("Gemini Response: ${response.body}");

    if (response.statusCode == 200) {

    final data = jsonDecode(response.body);

    String report =
    data["candidates"][0]["content"]["parts"][0]["text"];



    report = report
        .replaceAll("*", "")
        .replaceAll("#", "")
        .replaceAll("•", "-")
        .replaceAll("**", "")
        .replaceAll("```", "")
        .replaceAll("As an AI", "")
        .replaceAll("AI language model", "");


    if (report.length > 1500) {
    report = report.substring(0, 1500);
    }

    return report.trim();

    } else {

    return "AI Error: ${response.body}";

    }

    } catch (e) {

    return "AI request failed: $e";

    }

  }

}
