import "dart:async" show TimeoutException;
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:io";
// import "../models/api_response.dart";

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();

  late http.Client _client;
  String _baseUrl = "";
  Map<String, String> _defaultHeaders = {};
  Duration _timeout = const Duration(seconds: 10);

  factory HttpClient() {
    return _instance;
  }

  HttpClient._internal() {
    _client = http.Client();
    _initializeDefaultHeaders();
  }

  void initialize({
    required String baseUrl,
    Map<String, String>? customHeaders,
    Duration timeout = const Duration(seconds: 10),
  }) {
    _baseUrl = baseUrl;
    _timeout = timeout;
    _initializeDefaultHeaders();
    if (customHeaders != null) {
      _defaultHeaders.addAll(customHeaders);
    }
  }

  void _initializeDefaultHeaders() {
    _defaultHeaders = {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Connection": "keep-alive",
    };
  }

  void addHeader(String key, String value) {
    _defaultHeaders[key] = value;
  }

  void removeHeader(String key) {
    _defaultHeaders.remove(key);
  }

  Map<String, String> getHeaders() {
    return {..._defaultHeaders};
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final url = Uri.parse("$_baseUrl$endpoint").replace(queryParameters: queryParams?.cast<String, String>());
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client.get(url, headers: mergedHeaders).timeout(_timeout);

      return _handleResponse(response);
    } on SocketException catch (e) {
      // return ApiResponse(status: "error", message: "Network error: No internet connection ${e.message}");
      return {"status": "error", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      // return ApiResponse(status: "error", message: "Request timeout ${e.duration}s ${e.message}");
      return {"status": "error", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      // return ApiResponse(status: "error", message: "GET Error: $e");
      return {"status": "error", "message": "GET Error: $e"};
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic>? body, Map<String, String>? headers) async {
    try {
      final url = Uri.parse("$_baseUrl${normalizeEndpoint(endpoint)}");
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client
          .post(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException catch (e) {
      // return ApiResponse(status: "error", message: "Network error: No internet connection ${e.message}");
      return {"status": "error", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      // return ApiResponse(status: "error", message: "Request timeout ${e.duration}s ${e.message}");
      return {"status": "error", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      // return ApiResponse(status: "error", message: "POST Error: $e");
      return {"status": "error", "message": "POST Error: $e"};
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic>? body, Map<String, String>? headers) async {
    try {
      final url = Uri.parse("$_baseUrl${normalizeEndpoint(endpoint)}");
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client
          .put(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException catch (e) {
      // return ApiResponse(status: "error", message: "Network error: No internet connection ${e.message}");
      return {"status": "error", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      // return ApiResponse(status: "error", message: "Request timeout ${e.duration}s ${e.message}");
      return {"status": "error", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      // return ApiResponse(status: "error", message: "PUT Error: $e");
      return {"status": "error", "message": "PUT Error: $e"};
    }
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse("$_baseUrl${normalizeEndpoint(endpoint)}");
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client
          .patch(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException catch (e) {
      // return ApiResponse(status: "error", message: "Network error: No internet connection ${e.message}");
      return {"status": "error", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      // return ApiResponse(status: "error", message: "Request timeout ${e.duration}s ${e.message}");
      return {"status": "error", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      // return ApiResponse(status: "error", message: "PATCH Error: $e");
      return {"status": "error", "message": "PATCH Error: $e"};
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint, Map<String, dynamic>? body, Map<String, String>? headers) async {
    try {
      final url = Uri.parse("$_baseUrl${normalizeEndpoint(endpoint)}");
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client
          .delete(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException catch (e) {
      // return ApiResponse(status: "error", message: "Network error: No internet connection ${e.message}");
      return {"status": "error", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      // return ApiResponse(status: "error", message: "Request timeout ${e.duration}s ${e.message}");
      return {"status": "error", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      // return ApiResponse(status: "error", message: "DELETE Error: $e");
      return {"status": "error", "message": "DELETE Error: $e"};
    }
  }

  // Map<String, dynamic> _handleResponse(http.Response response, {required T Function(dynamic) dataParser}) {
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      if (kDebugMode) debugPrint("Http client handle response.body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        // if (response.body.isEmpty) {
        //   return ApiResponse<T>(status: "success", message: "");
        // }
        // final Map<String, dynamic> resDecode = jsonDecode(response.body);
        // if (resDecode.containsKey("status")) {
        //   return ApiResponse<T>.fromJson(resDecode, dataParser: dataParser);
        // }
        // return ApiResponse<T>(status: "success", data: dataParser(resDecode));
        return jsonDecode(response.body);
      }

      if (response.statusCode == 401) {
        // return ApiResponse<T>(status: "error", message: "Unauthorized: Token expired or invalid");
        return {"status": "error", "message": "Unauthorized: Token expired or invalid"};
      }
      if (response.statusCode == 403) {
        // return ApiResponse<T>(status: "error", message: "Unauthorized: Forbidden: Access denied");
        return {"status": "error", "message": "Unauthorized: Forbidden: Access denied"};
      }
      if (response.statusCode == 404) {
        // return ApiResponse<T>(status: "error", message: "Not Found: Resource does not exist");
        return {"status": "error", "message": "Not Found: Resource does not exist"};
      }
      // if (response.statusCode >= 500) return ApiResponse<T>(status: "error", message: "Server Error");
      if (response.statusCode >= 500) return {"status": "error", "message": "Server Error"};
      // return ApiResponse<T>(status: "error", message: "HTTP Error ${response.statusCode}: ${response.body}");
      return {"status": "error", "message": "HTTP Error ${response.statusCode}: ${response.body}"};
    } catch (e) {
      if (kDebugMode) debugPrint("❌ Error parsing response: $e");
      // return ApiResponse<T>(status: "error", message: "Failed to parse response: $e");
      return {"status": "error", "message": "Failed to parse response: $e"};
    }
  }

  void dispose() {
    _client.close();
  }
}

String normalizeEndpoint(String endpoint) {
  if (!endpoint.startsWith("/")) endpoint = "/$endpoint";
  return endpoint;
}
