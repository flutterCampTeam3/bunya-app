import 'dart:convert';

import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CheckOffice {
  Future checkOffice(String id) async {
    final String link =
        "https://api.wathq.sa/v5/commercialregistration/info/$id";
    final uri = Uri.parse(link);
    final request = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer ${dotenv.env["apiKey"]}",
        "Content-Type": "application/json"
      },
    );
    final response = jsonDecode(request.body);
    // if (request.statusCode >= 200 && request.statusCode <= 299) {
    //   // DBService().officeName = response["crName"];
    // } else {
    //   throw Exception(['لا يوجد سجل تجاري بهذا الرقم']);
    // }
  }
}
