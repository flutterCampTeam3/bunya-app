import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckOffice {
  Future<bool> checkOffice(String id) async {
    final String link =
        "https://api.wathq.sa/v5/commercialregistration/fullinfo/$id";
    final uri = Uri.parse(link);

    final Map<String, String> headers = {
      'apikey': 'J5eei6F5SH0qNVBg5fCo1ZYSAIzESAvZ',
      'Content-Type': 'application/json',
    };
    final request = await http.get(uri, headers: headers);
    final response = jsonDecode(request.body);
    print("$response");
    if (request.statusCode >= 200 && request.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }
}

