import 'dart:convert';
import 'package:call_log_management/api/api_constants.dart';
import 'package:call_log_management/model/aboutus';
import 'package:call_log_management/model/desiginationlist.dart';
import 'package:call_log_management/model/faqmodel.dart';
import 'package:call_log_management/model/loginresponse.dart';
import 'package:call_log_management/model/notifymodel.dart';
import 'package:call_log_management/model/postmodel.dart';
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
      "UserImage": "",
      "EmergencyContactPersion": user.emergencyContactPersion, // Corrected key
      "EmergencyContactMobile": user.emergencyContactMobile, // Corrected key
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

      print(response.body); // Debugging line

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["Status"] == 1) {
          // Update local user data
          ApiConstants.loginResponse.user = user;
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  static Future<List<FaqModel>> getFaq() async {
    final response = await http.post(
      Uri.parse("http://103.166.187.66/api/dynamic/public/103"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"UserId": 1}),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => FaqModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load FAQ");
    }
  }

  static Future<AboutUsModel> getAboutUs() async {
    final response = await http.post(
      Uri.parse(
        "http://103.166.187.66/api/dynamic/public/104",
      ), // YOUR FULL BASE URL here
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"PageKey": "AboutUs"}),
    );

    if (response.statusCode == 200) {
      return AboutUsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("About Us load failed");
    }
  }

  /// Fetch posts with pagination
  static Future<PostResponse> fetchPosts({
    required int userId,
    required int pageNumber,
    int pageSize = 10,
  }) async {
    final body = {
      "UserId": userId,
      "PageSize": pageSize,
      "PageNumber": pageNumber,
    };

    final response = await http.post(
      Uri.parse("http://103.166.187.66/api/dynamic/public/106"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return PostResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    final url = Uri.parse('http://103.166.187.66/api/dynamic/public/105');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"UserId": 1}),
    );

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  /// GET Static Content by PageKey
  static Future<Map<String, dynamic>> getStaticContent(String pageKey) async {
    final url = Uri.parse('http://103.166.187.66/api/dynamic/public/104');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"PageKey": pageKey}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load static content');
    }
  }

  /// Search posts API
  static Future<PostResponse> searchPosts({
    required int userId,
    required String searchTerm,
    required int pageNumber,
    required int pageSize,
  }) async {
    final url = Uri.parse('http://103.166.187.66/api/dynamic/public/107');

    final body = jsonEncode({
      "UserId": userId,
      "SearchTerm": searchTerm,
      "PageSize": pageSize,
      "PageNumber": pageNumber,
    });

    final headers = {"Content-Type": "application/json"};

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PostResponse.fromJson(data);
    } else {
      throw Exception("Failed to search posts: ${response.statusCode}");
    }
  }
}
