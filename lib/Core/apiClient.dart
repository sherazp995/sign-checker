import 'package:dio/dio.dart';
import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String? apiUrl = 'http://192.168.0.109:4000/';

  Future<dynamic> register(dynamic data) async {
    try {
      Response response =
          await _dio.post('${apiUrl}users/register', data: data);
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> login(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(
        '${apiUrl}users/login',
        data: data,
        // queryParameters: {'apikey': ApiSecret.apiKey},
      );

      if (response.data["status"] == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(response.data["result"]));
        prefs.setString('accessToken', response.data["jwtToken"]);
      }
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user = jsonDecode(prefs.getString('user')!);
      final accessToken = prefs.getString('accessToken');
      Response response = await _dio.get(
      '${apiUrl}users/${user['id']}',
      options: Options(
        headers: {'accesstoken': accessToken},
      ),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final user = jsonDecode(prefs.getString('user')!);
      final accessToken = prefs.getString('accessToken');
      Response response = await _dio.put(
        '${apiUrl}users/update/${user['id']}',
        data: data,
      options: Options(
        headers: {'accesstoken': accessToken},
      ),
      );
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('user');
      prefs.remove('accessToken');
      return true;
    } on Error catch (_) {
      return false;
    }
  }
}
