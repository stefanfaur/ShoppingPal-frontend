import 'package:http/http.dart' as http;

Future<http.Response> saveReceipt(String userId, String jsonData) async {
  var url =
      Uri.parse('http://192.168.2.139:8000/save-receipt/?user_id=$userId');

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonData,
  );

  return response;
}
