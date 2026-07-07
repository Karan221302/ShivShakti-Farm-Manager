import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/api_client.dart';

class AuthService {

  Future<bool> login(
      String username,
      String password,
      ) async {

    try {

      final response =
      await ApiClient.dio.post(

        "/api/auth/login",

        data: {

          "username": username,
          "password": password

        },

      );

      final prefs =
      await SharedPreferences.getInstance();

      await prefs.setString(
        "token",
        response.data["token"],
      );

      return true;

    } catch (e) {
      print("Login Error: $e");
      return false;

    }

  }

}