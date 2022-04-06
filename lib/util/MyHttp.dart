import 'dart:convert';

import 'package:after_school/model/api/response.dart';
import 'package:after_school/util/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MyHttp {
  String authorization = '';
  String baseUrl = dotenv.get('BASE_URL');
  // String contentType = 'application/json';
  // String accept = 'application/json';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static final MyHttp _instance = MyHttp._internal();

  factory MyHttp() => _instance;

  MyHttp._internal() {

  }

  setAuth(String token) {
    authorization = token;
    headers['Authorization'] = 'Bearer ' + authorization;
  }

  get() {

  }

  Future<ModelResponse> post(BuildContext context, String url, dynamic data) async {
    http.Response response =  await http.post(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonEncode(data));

    print('Response status: ${response.statusCode}');
    var responseBody = utf8.decode(response.bodyBytes);
    print('Response body: $responseBody');
    if (response.statusCode == 200) {
      return ModelResponse.fromJson(json.decode(responseBody));
      return json.decode(responseBody)['data'];
    } else {
      myShowDialog(context, "에러", "서버와 통신에 실패하였습니다.");
      throw Exception('Failed to load post');
    }
  }
}