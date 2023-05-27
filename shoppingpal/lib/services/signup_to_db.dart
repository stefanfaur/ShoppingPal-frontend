import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> createUser(String userId, String userEmail) async {
  var url = Uri.parse('http://192.168.2.139:8000/users/');

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': userId,
      'user_email': userEmail,
    }),
  );

  return response;
}
