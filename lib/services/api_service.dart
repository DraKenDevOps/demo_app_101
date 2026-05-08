import "package:demo_app_101/config.dart";
import "package:demo_app_101/utils/http_client.dart";
import "./storage_service.dart";

Future<void> main() async {
  HttpClient().initialize(baseUrl: "${AppConfig.API_BASE_URL}/api");
  String? token = await StorageService.getToken();
  if (token!.isNotEmpty) {
    HttpClient().addHeader("Authorization", "Bearer $token");
  }
}

class ApiService {
  final _http = HttpClient();
  Future<Map<String, dynamic>> listTravelSite(String? text) async {
    try {
      final response = await _http.get("/attractions", queryParams: {"search": text});
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> travelSiteDetail(String id) async {
    try {
      final response = await _http.get("/attractions/$id");
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> langTravelSiteDetail(String lang, String id) async {
    try {
      final response = await _http.get("/$lang/attractions/$id");
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> saveTravelSite(Map<String, dynamic> data) async {
    try {
      final response = await _http.post("/auth/attractions", data, null);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateTravelSite(Map<String, dynamic> data, String? id) async {
    try {
      final response = await _http.put("/auth/attractions", {"id": id, ...data}, null);
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteTravelSite(String id) async {
    try {
      final response = await _http.delete("/auth/attractions", { "id": id }, null);
      return response;
    } catch (err) {
      rethrow;
    }
  }
}
