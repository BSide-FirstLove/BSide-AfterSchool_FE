import 'dart:convert';
import 'dart:math';

import 'package:after_school/common/model/api/Join.dart';
import 'package:after_school/common/model/api/ModelResponse.dart';
import 'package:after_school/common/model/api/UserUpdate.dart';
import 'package:after_school/common/resources/Strings.dart';
import 'package:after_school/common/util/MyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/api/Login.dart';

class MyHttp {
  final CODE_SUCCESS = 1;
  String kakaoToken = '';
  String jwtToken = '';
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

  setKakaoToken(String token) {
    kakaoToken = token;
    headers['Authorization'] = 'Bearer ' + kakaoToken;
  }

  setJwtToken(String token) {
    jwtToken = token;
    headers['Authorization'] = 'Bearer ' + jwtToken;
  }

  get() {

  }

  Future<ModelResponse> post(String url, dynamic data) async {
    http.Response response = await http.post(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonEncode(data));

    print('Response status: ${response.statusCode}');
    var responseBody = utf8.decode(response.bodyBytes);
    print('Response body: $responseBody');
    if (response.statusCode == 200) {
      return ModelResponse.fromJson(json.decode(responseBody));
      return json.decode(responseBody)['data'];
    }
    else if(response.statusCode == 403) {
      bool flag = await refreshJwt();
      if(flag) {
        http.Response response2 = await http.post(
            Uri.parse(baseUrl + url),
            headers: headers,
            body: jsonEncode(data));
        print('Response2 status: ${response2.statusCode}');
        var responseBody = utf8.decode(response2.bodyBytes);
        print('Response2 body: $responseBody');
        if (response2.statusCode == 200) {
          return ModelResponse.fromJson(json.decode(responseBody));
        }
      }
      throw Exception(Strings.error1);
    }
    else {
      throw Exception(Strings.error1);
    }
  }

  Future<bool> refreshJwt() async {
    http.Response response = await http.post(
        Uri.parse(baseUrl + "auth/kakao"),
        headers: headers,
        body: jsonEncode(LoginReq(accessToken: kakaoToken).toJson()));
    print('Response status: ${response.statusCode}');
    var responseBody = utf8.decode(response.bodyBytes);
    print('Response body: $responseBody');
    if (response.statusCode == 200) {
      ModelResponse modelResponse = ModelResponse.fromJson(json.decode(responseBody));
      if(modelResponse.resultCode == CODE_SUCCESS) {
        Login modelLogin = Login.fromJson(modelResponse.data);
        if(!modelLogin.isNewMember) {
          setJwtToken(modelLogin.appToken!);
          return true;
        }
      }
    }
    return false;
  }

  Future<Login> login(LoginReq data) async {
    ModelResponse responseBody = await post('auth/kakao', data.toJson());
    if(responseBody.resultCode == CODE_SUCCESS) {
      Login modelLogin = Login.fromJson(responseBody.data);
      if(!modelLogin.isNewMember) {
        setJwtToken(modelLogin.appToken!);
      }
      return modelLogin;
    }else {
      throw Exception(Strings.errorLogin);
    }
  }

  Future<Join> join(JoinReq data) async {
    ModelResponse responseBody = await post('auth/regist', data.toJson());
    if(responseBody.resultCode == CODE_SUCCESS) {
      Join modelJoin = Join.fromJson(responseBody.data);
      setJwtToken(modelJoin.appToken!);
      return modelJoin;
    }else {
      throw Exception(Strings.errorJoin);
    }
  }

  Future<UserUpdate> userUpdate(UserUpdateReq data) async {
    ModelResponse responseBody = await post('user/update', data.toJson());
    if(responseBody.resultCode == CODE_SUCCESS) {
      UserUpdate userUpdateModel = UserUpdate.fromJson(responseBody.data);
      return userUpdateModel;
    }else {
      throw Exception(Strings.errorUserUpdate);
    }
  }
}