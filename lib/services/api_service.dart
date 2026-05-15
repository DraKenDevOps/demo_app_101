// import "../config.dart";
// import "../models/api_response.dart";
import "../utils/http_client.dart";
// import "storage_service.dart";

class ApiService {
  final HttpClient _http = HttpClient();

  // void initState() async {
  //   _http.initialize(baseUrl: AppConfig.API_BASE_URL);
  //   String? token = await StorageService.getToken();
  //   if (token != null && token.isNotEmpty) {
  //     _http.addHeader("Authorization", "Bearer $token");
  //   }
  // }

  Future<Map<String, dynamic>> listTravelSite(
    String? text,
    int? page,
    int? limit,
    String? sort_col,
    String? sort_order,
  ) async {
    Map<String, dynamic> qs = {};
    if (text != null && text.isNotEmpty) qs["search"] = text;
    if (page != null && !page.isNaN) qs["page"] = page;
    if (limit != null && !limit.isNaN) qs["per_page"] = limit;
    if (sort_col != null && sort_col.isNotEmpty) qs["sort_column"] = sort_col;
    if (sort_order != null && sort_order.isNotEmpty) qs["sort_order"] = sort_order;
    final response = await _http.get("/attractions", queryParams: qs);
    return response;
  }

  Future<Map<String, dynamic>> travelSiteDetail(String id) async {
    final response = await _http.get("/attractions/$id");
    return response;
  }

  Future<Map<String, dynamic>> langTravelSiteDetail(String lang, String id) async {
    final response = await _http.get("/$lang/attractions/$id");
    return response;
  }

  Future<Map<String, dynamic>> saveTravelSite(Map<String, dynamic> data) async {
    final response = await _http.post("/auth/attractions", data, null);
    return response;
  }

  Future<Map<String, dynamic>> updateTravelSite(Map<String, dynamic> data, String? id) async {
    final response = await _http.put("/auth/attractions", {"id": id, ...data}, null);
    return response;
  }

  Future<Map<String, dynamic>> deleteTravelSite(String id) async {
    final response = await _http.delete("/auth/attractions", {"id": id}, null);
    return response;
  }

  // Future<ApiResponse> listTravelSite(
  //   String? text,
  //   int? page,
  //   int? limit,
  //   String? sort_col,
  //   String? sort_order,
  // ) async {
  //   Map<String, dynamic> qs = {};
  //   if (text != null && text.isNotEmpty) qs["search"] = text;
  //   if (page != null && !page.isNaN) qs["page"] = page;
  //   if (limit != null && !limit.isNaN) qs["per_page"] = limit;
  //   if (sort_col != null && sort_col.isNotEmpty) qs["sort_column"] = sort_col;
  //   if (sort_order != null && sort_order.isNotEmpty) qs["sort_order"] = sort_order;
  //   ApiResponse response = await _http.get("/attractions", queryParams: qs);
  //   return response;
  // }

  // Future<ApiResponse> travelSiteDetail(String id) async {
  //   ApiResponse response = await _http.get("/attractions/$id");
  //   return response;
  // }

  // Future<ApiResponse> langTravelSiteDetail(String lang, String id) async {
  //   ApiResponse response = await _http.get("/$lang/attractions/$id");
  //   return response;
  // }

  // Future<ApiResponse> saveTravelSite(Map<String, dynamic> data) async {
  //   ApiResponse response = await _http.post("/auth/attractions", data, null);
  //   return response;
  // }

  // Future<ApiResponse> updateTravelSite(Map<String, dynamic> data, String? id) async {
  //   ApiResponse response = await _http.put("/auth/attractions", {"id": id, ...data}, null);
  //   return response;
  // }

  // Future<ApiResponse> deleteTravelSite(String id) async {
  //   ApiResponse response = await _http.delete("/auth/attractions", {"id": id}, null);
  //   return response;
  // }
}
