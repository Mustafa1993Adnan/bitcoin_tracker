import 'dart:convert' as convert;
// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({@required this.url});
  final String url;
  Future getData() async {
    var fullURL = Uri.parse(url);
    var response = await http.get(fullURL);
    if (response.statusCode == 200) {
      String data = response.body;
      return convert.jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
