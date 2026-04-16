import 'dart:convert';
import 'package:http/http.dart' as http;

class SavayaBotService {

  static const String apiKey = "AIzaSyBqS9tbFaMyPuKUheDGMESDJU5RMnDbpG0";

  static Future<String> askSavaya(String question) async {

    String prompt = """
You are SAVAYA BOT, a smart financial assistant.

Answer the user's finance question clearly and briefly.

User Question:
$question

Give practical financial advice in short explanation.
""";

    final response = await http.post(
      Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey"
      ),
      headers: {"Content-Type": "application/json"},
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

    final data = jsonDecode(response.body);

    String responseText =
    data["candidates"][0]["content"]["parts"][0]["text"];

    responseText = responseText.replaceAll("*", "");
    responseText = responseText.replaceAll("#", "");
    responseText = responseText.replaceAll("•", "");
    responseText = responseText.replaceAll("**", "");

    return responseText;
  }
}