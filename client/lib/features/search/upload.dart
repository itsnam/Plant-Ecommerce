import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

Future upload(File image) async {
  var uri = Uri.parse("http://10.0.2.2:3000/api/plants/predict");
  var request = MultipartRequest('POST', uri);
  request.files.add(MultipartFile.fromBytes("image", image.readAsBytesSync(),
      filename: "image", contentType: MediaType('image', 'jpeg')));
  var response = await request.send();
  if (response.statusCode == 200) {
    print(json.decode(await response.stream.bytesToString()));
  }else{
    throw Exception('Server error!');
  }
}
