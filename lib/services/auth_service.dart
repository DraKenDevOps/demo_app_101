import "package:demo_app_101/utils/http_client.dart";

class AuthService {
  final _http = HttpClient();
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      final response = await _http.post("/login", data, null);
      return response;
    } catch (err) {
      rethrow;
    }
  }
}
