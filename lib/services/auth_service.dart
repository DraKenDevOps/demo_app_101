import "../utils/http_client.dart";
import "./storage_service.dart";

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

  void logout() {
    StorageService.deleteToken();
  }
}
