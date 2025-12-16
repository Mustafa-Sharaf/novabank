import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import "package:http/http.dart" as http;
const String baseUrl = "http://novasys.runasp.net/api/";



class HttpHelper {


  static Future<Map<String, dynamic>> postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final storage = GetStorage();
    final token = storage.read("token");

    final url = Uri.parse(baseUrl + endpoint);

    final defaultHeaders = {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
      ...?headers,
    };

    try {
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          "success": true,
          "status": response.statusCode,
          "data": jsonDecode(response.body),
        };
      }

      if (response.statusCode == 401) {
        final refreshed = await _refreshToken();
        if (refreshed) {
          return postRequest(
            endpoint: endpoint,
            body: body,
            headers: headers,
          );
        }
      }

      return {
        "success": false,
        "status": response.statusCode,
        "message": response.body,
      };
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }


  static Future<Map<String, dynamic>> postMultipartRequest({
    required String endpoint,
    required Map<String, String> fields,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll(fields);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      return {
        "success": response.statusCode >= 200 && response.statusCode < 300,
        "status": response.statusCode,
        "body": respStr,
        "message": respStr.isNotEmpty ? respStr : null,
      };
    } catch (e) {
      return {
        "success": false,
        "status": null,
        "body": null,
        "message": e.toString(),
      };
    }
  }



  static Future<Map<String, dynamic>> getRequest({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final storage = GetStorage();
    final token = storage.read("token");

    final url = Uri.parse(baseUrl + endpoint);

    final defaultHeaders = {
      if (token != null) "Authorization": "Bearer $token",
      ...?headers,
    };

    try {
      final response = await http.get(url, headers: defaultHeaders);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "status": response.statusCode,
          "message": response.body
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }






  static Future<bool> _refreshToken() async {
    final storage = GetStorage();

    final refreshToken = storage.read("refreshToken");
    final token = storage.read("token");

    if (refreshToken == null || token == null) return false;

    final url = Uri.parse("${baseUrl}users/token/refresh");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "refreshToken": refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await storage.write("token", data["token"]);
        await storage.write("refreshToken", data["refreshToken"]);

        return true;
      }
    } catch (_) {}

    return false;
  }

}




/*static Future<Map<String, dynamic>> postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    final defaultHeaders = {
      "Content-Type": "application/json",
      ...?headers,
    };

    try {
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          "success": true,
          "status": response.statusCode,
          "data": jsonDecode(response.body),
        };
      } else {
        return {
          "success": false,
          "status": response.statusCode,
          "message": response.body,
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }*/


/*
  static Future<Map<String, dynamic>> getRequest({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {"success": false, "message": response.body};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
*/