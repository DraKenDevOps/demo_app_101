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
  Duration _timeout = const Duration(seconds: 30);

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
    Duration timeout = const Duration(seconds: 30),
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
      throw Exception("Network error: No internet connection $e");
    } on TimeoutException {
      throw Exception("Request timeout");
    } catch (e) {
      throw Exception("GET Error: $e");
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
    } on SocketException {
      throw Exception("Network error: No internet connection");
    } on TimeoutException {
      throw Exception("Request timeout");
    } catch (e) {
      throw Exception("POST Error: $e");
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
    } on SocketException {
      throw Exception("Network error");
    } on TimeoutException {
      throw Exception("Request timeout");
    } catch (e) {
      throw Exception("PUT Error: $e");
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
    } catch (e) {
      throw Exception("PATCH Error: $e");
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint, Map<String, dynamic>? body, Map<String, String>? headers) async {
    try {
      final url = Uri.parse("$_baseUrl${normalizeEndpoint(endpoint)}");
      final mergedHeaders = {..._defaultHeaders, ...?headers};
      final response = await _client.delete(url, headers: mergedHeaders, body: body != null ? jsonEncode(body) : null).timeout(_timeout);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE Error: $e");
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (kDebugMode) debugPrint("Http client handle response: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      if (response.body.isEmpty) {
        return {"status": "success", "data": null};
      }
      return jsonDecode(response.body);
    }

    if (response.statusCode == 401) {
      throw UnauthorizedException("Unauthorized: Token expired or invalid");
    }

    if (response.statusCode == 403) {
      throw ForbiddenException("Forbidden: Access denied");
    }

    if (response.statusCode == 404) {
      throw NotFoundException("Not Found: Resource does not exist");
    }

    if (response.statusCode >= 500) {
      throw ServerException("Server Error: ${response.statusCode}");
    }

    throw HttpException("HTTP Error ${response.statusCode}: ${response.body}");
  }

  void dispose() {
    _client.close();
  }
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);
  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() => message;
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}

String normalizeEndpoint(String endpoint) {
  if (!endpoint.startsWith("/")) endpoint = "/$endpoint";
  return endpoint;
}
