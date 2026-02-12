import 'dart:convert';
import 'package:call_log_management/model/loginresponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  static const String baseUrl = "http://103.166.187.66/api/Authentication/login";

  static Future<LoginResponse?> login(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "Username": username,
          "Password": password,
        }),
      );

      if (response.statusCode == 200) {
        final loginResponse =
            loginResponseFromJson(response.body);

        // Save token locally
        if (loginResponse.token != null) {
          SharedPreferences prefs =
              await SharedPreferences.getInstance();
          await prefs.setString("token", loginResponse.token!);
        }

        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }
}
