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
    const String kay = "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";
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

//   Future<String> getChatAnswerImage(String prompt) async {
//     const String link2 = "https://api.openai.com/v1/images/generations";
//     final uri = Uri.parse(link2);
//     late String imageUrl;
//     const String kay = "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";
//     Map<String, String> header = {
//       "Authorization": "Bearer $kay",
//       "Content-Type": "application/json"
//     };
//     final body = {
//       "model": "dall-e-2",
//       'prompt': prompt,
//       'size': '1024x1024',
//       'quality': 'standard',
//       'n': 1
//     };
//     print("--------1----------");
//     final requset = await http
//         .post(uri, headers: header, body: jsonEncode(body))
//         .then((value) {
//       print("----------2-------");
//       print("body:  ${value.body}");
      // final response = jsonDecode(utf8.decode(value.bodyBytes));
//       imageUrl = response['data'][0]['url'];
//       print(" in the then : $imageUrl");
//     });
//     return imageUrl;
//   }
}






// import 'dart:convert';

// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;

// import 'supabase_services.dart';

// class GPT {
//   final locator = GetIt.I.get<DBService>();
// String key = "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";

//   String link = "https://api.openai.com/v1/chat/completions";

//   Future<String> getChatAnswer(String prompt) async {
//     print("hh");
//     final uri = Uri.parse(link);
//     String answer = "empty";
//     final request = await http
//         .post(uri,
//             headers: {
//               "Authorization": "Bearer $key",
//               "Content-Type": "application/json"
//             },
            // body: jsonEncode(
            //   {
            //     "model": "gpt-3.5-turbo",
            //     "messages": [
            //       {
            //         "role": "system",
            //         "content":
            //             "  startsSpeak to him by his name  ${  locator.name} , play role you are a helpful medical  bot know about medicine and provide advice in a short words ,Just answer in Arabic and Just answer  For medical questions ",
            //       },
            //       {
            //         "role": "user",
            //         "content": prompt,
            //       }
            //     ]
            //   },
            // ))
//         .then((value) {
//       print("Answer: ${value.body}");
//       final response = jsonDecode(utf8.decode(value.bodyBytes));
//       answer = response["choices"][0]["message"]["content"];
//     });
// print(answer);
//     return answer;
//   }
// }
