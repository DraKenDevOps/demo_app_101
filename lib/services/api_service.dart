import "../utils/http_client.dart";

class ApiService {
  final _http = HttpClient();
  Future<Map<String, dynamic>> listTravelSite(String? text, int? page, int? limit, String? sort) async {
    Map<String, dynamic> qs = {};
    if (text != null && text.isNotEmpty) qs["search"] = text;
    if (page != null && !page.isNaN) qs["page"] = page;
    if (limit != null && !limit.isNaN) qs["limit"] = limit;
    if (sort != null && sort.isNotEmpty) qs["sort"] = sort;
    try {
      final response = await _http.get(
        "/attractions",
        queryParams: qs,
      );
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
      final response = await _http.delete("/auth/attractions", {"id": id}, null);
      return response;
    } catch (err) {
      rethrow;
    }
  }
}
