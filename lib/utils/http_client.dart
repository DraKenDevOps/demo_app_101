import "dart:async" show TimeoutException;
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:io";

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
      return {"status": "ERROR", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      return {"status": "ERROR", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      return {"status": "ERROR", "message": "GET Error: $e"};
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
      return {"status": "ERROR", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      return {"status": "ERROR", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      return {"status": "ERROR", "message": "POST Error: $e"};
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
      return {"status": "ERROR", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      return {"status": "ERROR", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      return {"status": "ERROR", "message": "PUT Error: $e"};
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
      return {"status": "ERROR", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      return {"status": "ERROR", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      return {"status": "ERROR", "message": "PATCH Error: $e"};
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
      return {"status": "ERROR", "message": "Network error: No internet connection ${e.message}"};
    } on TimeoutException catch (e) {
      return {"status": "ERROR", "message": "Request timeout ${e.duration}s ${e.message}"};
    } catch (e) {
      return {"status": "ERROR", "message": "DELETE Error: $e"};
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      if (kDebugMode) debugPrint("Http client handle response.body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return jsonDecode(response.body);
      }

      if (response.statusCode == 401) {
        return {"status": "ERROR", "message": "Unauthorized: Token expired or invalid"};
      }
      if (response.statusCode == 403) {
        return {"status": "ERROR", "message": "Unauthorized: Forbidden: Access denied"};
      }
      if (response.statusCode == 404) {
        return {"status": "ERROR", "message": "Not Found: Resource does not exist"};
      }
      if (response.statusCode >= 500) return {"status": "ERROR", "message": "Server Error"};
      return {"status": "ERROR", "message": "HTTP Error ${response.statusCode}: ${response.body}"};
    } catch (e) {
      if (kDebugMode) debugPrint("❌ Error parsing response: $e");
      return {"status": "ERROR", "message": "Failed to parse response: $e"};
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
