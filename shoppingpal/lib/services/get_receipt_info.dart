import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getReceiptInfo(String receiptId) async {
  var url = Uri.parse('http://localhost:8000/receipts/$receiptId/items');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load receipts');
  }
}
