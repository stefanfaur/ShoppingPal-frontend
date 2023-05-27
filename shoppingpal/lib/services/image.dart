import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<Map<String, dynamic>> uploadImage(File imageFile) async {
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();

  // this ip always changes as the router assigns it
  // TODO: eventually run the backend in the cloud with a static ip
  var uri = Uri.parse("http://localhost:8000/upload-image/");
  var request = http.MultipartRequest("POST", uri);
  request.headers.addAll({
    'Content-Type': 'multipart/form-data',
  });

  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));
  request.files.add(multipartFile);

  var response = await request.send();
  String responseAsString =
      await response.stream.transform(utf8.decoder).join();

  print(responseAsString);
  return jsonDecode(responseAsString);
}
