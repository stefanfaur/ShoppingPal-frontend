import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getUserInfo(String userId) async {
  var url = Uri.parse('http://192.168.2.139:8000/users/$userId');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load receipts');
  }
}
