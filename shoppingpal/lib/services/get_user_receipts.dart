import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserReceipts(String userId) async {
  var url = Uri.parse('http://localhost:8000/receipts/$userId');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load receipts');
  }
}
