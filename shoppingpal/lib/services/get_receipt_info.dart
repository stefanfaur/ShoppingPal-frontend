import 'package:http/http.dart' as http;

Future<http.Response> getReceiptInfo(String receiptId) async {
  var url = Uri.parse('http://172.20.10.2:8000/receipts/$receiptId/items');

  var response = await http.get(url);

  return response;
}
