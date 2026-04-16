import 'dart:convert';
import 'package:http/http.dart' as http;

class AIAssetRecommender {

  static const String apiKey = "AIzaSyBqS9tbFaMyPuKUheDGMESDJU5RMnDbpG0";

  static Future<Map<String, dynamic>> generateAssets({
    required double income,
    required double savings,
    required String risk
  }) async {


    String prompt = """
```

You are an advanced financial investment AI.

Based on the user's financial profile, recommend investment assets.

User Profile:
Income: $income Rupees
Savings: $savings Rupees
Risk Level: $risk

Recommend assets across the following categories:

1. Indian Stocks
2. Mutual Funds
3. ETFs
4. Crypto
5. Gold
6. REITs

For each category recommend EXACTLY 3 assets.

Return ONLY JSON in this format:

{
"stocks":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
],
"mutualFunds":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
],
"etfs":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
],
"crypto":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
],
"gold":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
],
"reits":[
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""},
{"name":"","symbol":"","reason":""}
]
}
""";


    try {

    final response = await http.post(
    Uri.parse(
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey"
    ),
    headers: {
    "Content-Type": "application/json"
    },
    body: jsonEncode({
    "contents":[
    {
    "parts":[
    {"text": prompt}
    ]
    }
    ]
    })
    );

    final data = jsonDecode(response.body);

    String text =
    data["candidates"][0]["content"]["parts"][0]["text"];

    text = text.replaceAll("```json", "");
    text = text.replaceAll("```", "");

    return jsonDecode(text);

    } catch (e) {

    print("AI Asset generation failed: $e");

    return {};

    }


  }
}
