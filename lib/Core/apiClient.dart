import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String? apiUrl = dotenv.env['BASE_URL'];

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response =
          await _dio.post('${apiUrl}users/register', data: data);
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${apiUrl}users/login',
        data: {
          'email': email,
          'password': password,
        },
        // queryParameters: {'apikey': ApiSecret.apiKey},
      );

      if (response.data.status == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', response.data.result);
        prefs.setString('accessToken', response.data.jwtToken);
      }
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    try {
      // Response response = await _dio.get(
      //   'https://api.loginradius.com/identity/v2/auth/account',
      // queryParameters: {'apikey': ApiSecret.apiKey},
      // options: Options(
      //   headers: {'Authorization': 'Bearer $accessToken'},
      // ),
      // );
      // return response.data;
      return null;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      // Response response = await _dio.put(
      //   'https://api.loginradius.com/identity/v2/auth/account',
      //   data: data,
      // queryParameters: {'apikey': ApiSecret.apiKey},
      // options: Options(
      //   headers: {'Authorization': 'Bearer $accessToken'},
      // ),
      // );
      // return response.data;
      return null;
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