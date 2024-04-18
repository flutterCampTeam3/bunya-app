import 'dart:convert';

import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CheckOffice {
  Future<bool> checkOffice(String id) async {
    print("in the func");
    final String link =
        "https://api.wathq.sa/v5/commercialregistration/fullinfo/$id";
    final uri = Uri.parse(link);

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${dotenv.env["apiKey"]}',
      'Content-Type': 'application/json',
    };
    final request = await http.get(uri, headers: headers);
    final response = jsonDecode(request.body);
    print("$response");
    print(" ");
    if (request.statusCode >= 200 && request.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }
}
