import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'supabase_services.dart';

class GPT {
  final locator = GetIt.I.get<DBService>();
  Future<String> getChatAnswer(String prompt) async {
    
    String link = "https://api.openai.com/v1/chat/completions";
    final uri = Uri.parse(link);
    String answer = 'empty';
    const String kay = "";
    Map<String, String> header = {
      "Authorization": "Bearer $kay",
      "Content-Type": "application/json"
    };
    final body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
              "   play role you are a helpful  specializes bot  in the field of construction and helps those who need advice on building their home, including interior and exterior design, electricity, building materials, etc  ,provide advice in a short words ,Just answer in Arabic and Just answer  For medical questions "
        },
        {"role": "user", "content": prompt}
      ]
    };
    final requset = await http
        .post(uri, headers: header, body: jsonEncode(body))
        .then((value) {
      print(" in the then : ${value.body}");
     final response = jsonDecode(utf8.decode(value.bodyBytes));
      answer = response["choices"][0]["message"]["content"];
      print(" after : $answer");
    });
    return answer;
  }

}




