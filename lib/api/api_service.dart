import 'dart:convert';
import 'package:call_log_management/api/api_constants.dart';
import 'package:call_log_management/model/desiginationlist.dart';
import 'package:call_log_management/model/loginresponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://103.166.187.66/api/Authentication";

  // Login API (already exists)
  static Future<LoginResponse?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"Username": username, "Password": password}),
      );

      if (response.statusCode == 200) {
        final loginResponse = loginResponseFromJson(response.body);

        if (loginResponse.token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
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

  // Generic method to get Department or Designation
  static Future<List<DesignationList>> getDropdownList(
    String requestFor,
    int userId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final url = Uri.parse("http://103.166.187.66/api/dynamic/public/100");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"RequestFor": requestFor, "UserId": userId}),
      );

      if (response.statusCode == 200) {
        return designationListFromJson(response.body);
      }
      return [];
    } catch (e) {
      print("Get $requestFor Error: $e");
      return [];
    }
  }


  /// Update user profile
  static Future<bool> updateUserProfile(User user) async {
    final url = Uri.parse("http://103.166.187.66/api/dynamic/authorized/101");

    // Prepare JSON body
    final Map<String, dynamic> body = {
      "UserId": user.userId,
      "DisplayName": user.displayName,
      "Email": user.email,
      "Mobile": user.mobile,
      "EmergencyContactPerson": user.emergencyContactMobile, // Corrected key
      "PresentAddress": user.presentAddress,
      "PermanentAddress": user.permanentAddress,
      "DepartmentId": user.departmentId,
      "DesignationId": user.designationId,
      "IsActive": true,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${ApiConstants.token}",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["Status"] == 1) {
          // Update local user data
          ApiConstants.loginResponse.user = User.fromJson(body);
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }
}
